Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261623AbTCGPWg>; Fri, 7 Mar 2003 10:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261626AbTCGPWg>; Fri, 7 Mar 2003 10:22:36 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:5013 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S261623AbTCGPWf>; Fri, 7 Mar 2003 10:22:35 -0500
Date: Fri, 7 Mar 2003 09:33:00 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Roman Zippel <zippel@linux-m68k.org>, Greg KH <greg@kroah.com>,
       Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] klibc for 2.5.64 - try 2
In-Reply-To: <3E68A1F3.2020006@zytor.com>
Message-ID: <Pine.LNX.4.44.0303070928560.26430-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Mar 2003, H. Peter Anvin wrote:

> Roman Zippel wrote:
> > 
> > You are avoiding my question. If something goes into the kernel, the 
> > kernel license would be the obvious choice. Granting additional rights or 
> > using a dual license is a relatively small problem. But you must certainly 
> > have a reason to choose a completely different license?
> > 
> 
> I gave my reason.  You chose not to accept it, but that's not my problem.

Correct me, IANAL, but my understanding is that klibc will be dual 
GPL/<whatever it is now> by inclusion into the kernel tree, after all the 
whole purpose is to provide an initramfs which will be linked into vmlinux 
(Yes, linked not in the normal sense, but still). 

So it'd rather be similar to some parts of the kernel which are already
dual licensed (parts of ACPI I think being the latest example), and
patches will be assumed to be contributed under that dual license, unless
explicitly stated otherwise.

Or not?

--Kai


