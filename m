Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132894AbRDENTU>; Thu, 5 Apr 2001 09:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132895AbRDENTK>; Thu, 5 Apr 2001 09:19:10 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:46047 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S132894AbRDENS7>; Thu, 5 Apr 2001 09:18:59 -0400
Date: Thu, 5 Apr 2001 15:15:26 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        James Simmons <jsimmons@linux-fbdev.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: fbcon slowness [was NTP on 2.4.2?]
In-Reply-To: <Pine.LNX.4.05.10104051410440.25540-100000@callisto.of.borg>
Message-ID: <Pine.GSO.3.96.1010405150444.21134E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Apr 2001, Geert Uytterhoeven wrote:

> > 32bit writes on a bus with a word size of 64 or more bits.  By the way
> > does anyone know who didn't implement MTRR's or the equivalent on
> > alpha so we can shoot them?
> 
> People never get shot in Open Source projects. Not when they write buggy code,
> not when they don't implement some features.

 Was DEC Alpha an Open Source project? ;-)

 Memory barriers are more RISC-styled and more flexible anyway (e.g. you
can't run out of them ;-) ), though they require a greater care when
writing code.  MTRRs are the Intel style of complicating designs.  Still
they are probably a reasonable solution to preserve DOS compatibility. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

