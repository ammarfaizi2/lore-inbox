Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132167AbRDFRtJ>; Fri, 6 Apr 2001 13:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132186AbRDFRs6>; Fri, 6 Apr 2001 13:48:58 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:53230 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S132167AbRDFRsi>; Fri, 6 Apr 2001 13:48:38 -0400
Date: Fri, 6 Apr 2001 19:27:24 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James Simmons <jsimmons@linux-fbdev.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: fbcon slowness [was NTP on 2.4.2?]
In-Reply-To: <m13dbmw4he.fsf@frodo.biederman.org>
Message-ID: <Pine.GSO.3.96.1010406191454.15958I-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 Apr 2001, Eric W. Biederman wrote:

> I recall on the ev6 all memory accesses to locations with bit 40 set 
> are always to IO space are never cached and are never write buffered.

 If that is the case then EV6 is seriously flawed.  You normally have
non-cached locations buffered (since you don't always need peripheral
device accesses to be posted immediately) and can force a writeback with a
memory barrier.  I don't have my 21264 handbook handy, so I can't check
EV6 details at the moment, especially why it is different.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

