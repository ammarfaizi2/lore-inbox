Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266737AbUHaG1B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266737AbUHaG1B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 02:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266745AbUHaG1B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 02:27:01 -0400
Received: from acheron.informatik.uni-muenchen.de ([129.187.214.135]:41947
	"EHLO acheron.informatik.uni-muenchen.de") by vger.kernel.org
	with ESMTP id S266737AbUHaG06 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 02:26:58 -0400
Message-ID: <41341A31.3050301@bio.ifi.lmu.de>
Date: Tue, 31 Aug 2004 08:26:57 +0200
From: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040503)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Tim Fairchild <tim@bcs4me.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: K3b and 2.6.9?
References: <200408301047.06780.tim@bcs4me.com> <1093871277.30082.7.camel@localhost.localdomain> <200408311151.25854.tim@bcs4me.com> <Pine.LNX.4.58.0408301917360.2295@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0408301917360.2295@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> Ehh.. This seems to imply that K3b opens the device for _reading_ when it 
> wants to burn a CD-ROM. 

It seems that this problem is not K3B-only:

Marc Ballarin wrote:

> growisofs and dvd+r-format open the device read-only, even though they try
> to do writes.
 >
> ...
>
> 2) replace O_RDONLY in dvd+r-tools sources with O_RDWR and recompile
> (that's what I did).


cu,
Frank

-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049

