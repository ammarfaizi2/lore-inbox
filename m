Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317251AbSGHXXZ>; Mon, 8 Jul 2002 19:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317258AbSGHXXY>; Mon, 8 Jul 2002 19:23:24 -0400
Received: from modemcable130.10-203-24.mtl.mc.videotron.ca ([24.203.10.130]:38662
	"EHLO evanidus.ath.cx") by vger.kernel.org with ESMTP
	id <S317251AbSGHXXX>; Mon, 8 Jul 2002 19:23:23 -0400
Date: Mon, 08 Jul 2002 19:27:21 -0400
From: Sanctus Evanidus <evanidus@videotron.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: Patch for Menuconfig script
Message-ID: <3D2A1FD9.nailEY1K2ZSH@videotron.ca>
References: <21071.1026168807@ocs3.intra.ocs.com.au>
In-Reply-To: <21071.1026168807@ocs3.intra.ocs.com.au>
User-Agent: nail 9.27 5/13/01
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Keith Owens <kaos@ocs.com.au> wrote:

> The #! line is irrelevant.  The script is invoked via
>
>   $(CONFIG_SHELL) scripts/Menuconfig arch/$(ARCH)/config.in
>
> Large chunks of kbuild assume that CONFIG_SHELL is bash.  Don't bother
> trying to cleanup all the code that assumes bash, just
>   make CONFIG_SHELL=/path/to/bash ...

I personaly don't think it should be assumed that every systems even has bash installed, but instead that every systems have a POSIX compilant sh.

In other words, without cleanups, someone who want to execute that script would be "forced" to install bash.

-Evan
