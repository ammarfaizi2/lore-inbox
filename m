Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266067AbRF1RwP>; Thu, 28 Jun 2001 13:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266064AbRF1RwF>; Thu, 28 Jun 2001 13:52:05 -0400
Received: from boreas.isi.edu ([128.9.160.161]:32662 "EHLO boreas.isi.edu")
	by vger.kernel.org with ESMTP id <S266060AbRF1Rv6>;
	Thu, 28 Jun 2001 13:51:58 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Cosmetic JFFS patch. 
In-Reply-To: Your message of "Thu, 28 Jun 2001 18:14:15 BST."
             <E15FfMt-0007Ht-00@the-village.bc.nu> 
Date: Thu, 28 Jun 2001 10:51:50 -0700
Message-ID: <503.993750710@ISI.EDU>
From: Craig Milo Rogers <rogers@ISI.EDU>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Q: Would it be worth making the module author/version strings survive in
>a non modular build but stuffed into their own section so you can pull them
>out with some magic that we'd include in 'REPORTING-BUGS'

	In a /proc file, maybe?  A single file ("/proc/authors"?
"/proc/versions"? "/proc/brags"? "/proc/kvell"?)  could present the
whole section.  Alternatively, you could have one /proc file per
attributed source file; I suspect that would be messier to code.  In a
modular system, would it be feasible to dynamically link/unlink
attribution strings from a global list as modules are loaded/unloaded,
and display linked attributions along with static ones in the /proc
file?

	Extrapolating from past behavior into the future:  someone will
submit code with a multi-page attribution string.  It is likely that
we'd need a formal policy on the length, content, and maybe even format
of attribution strings.

					Craig Milo Rogers

