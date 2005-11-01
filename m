Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750850AbVKAPQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbVKAPQF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 10:16:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750854AbVKAPQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 10:16:05 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:22277 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1750850AbVKAPQD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 10:16:03 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, zippel@linux-m68k.org, ak@suse.de,
       rmk+lkml@arm.linux.org.uk, tony.luck@gmail.com,
       paolo.ciarrocchi@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: New (now current development process)
References: <4d8e3fd30510291026x611aa715pc1a153e706e70bc2@mail.gmail.com>
	<20051031001647.GK2846@flint.arm.linux.org.uk>
	<20051030172247.743d77fa.akpm@osdl.org>
	<200510310341.02897.ak@suse.de>
	<Pine.LNX.4.61.0511010039370.1387@scrub.home>
	<20051031160557.7540cd6a.akpm@osdl.org>
	<Pine.LNX.4.64.0510311611540.27915@g5.osdl.org>
	<20051031163408.41a266f3.akpm@osdl.org>
From: Nix <nix@esperi.org.uk>
X-Emacs: where editing text is like playing Paganini on a glass harmonica.
Date: Tue, 01 Nov 2005 15:15:03 +0000
In-Reply-To: <20051031163408.41a266f3.akpm@osdl.org> (Andrew Morton's
 message of "1 Nov 2005 00:34:30 -0000")
Message-ID: <87k6fs4cy0.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 Nov 2005, Andrew Morton stated:
> gcc-2.95.4:
> 
> 	bix:/usr/src/25> size vmlinux 
> 	   text    data     bss     dec     hex filename
> 	 665502  152379   55120  873001   d5229 vmlinux
> 
> gcc version 4.1.0 20050513 (experimental):
> 
> 	bix:/usr/src/25> size vmlinux
> 	   text    data     bss     dec     hex filename
> 	 761415  151851   55280  968546   ec762 vmlinux
> 
> (There's a new reason for retaining gcc-2.95.x support)

What if you build with -Os? That tends to hold alignments down quite a
bit.

(I'll try it this evening...)

-- 
`"Gun-wielding recluse gunned down by local police" isn't the epitaph
 I want. I am hoping for "Witnesses reported the sound up to two hundred
 kilometers away" or "Last body part finally located".' --- James Nicoll
