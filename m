Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289119AbSANWne>; Mon, 14 Jan 2002 17:43:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289122AbSANWmN>; Mon, 14 Jan 2002 17:42:13 -0500
Received: from offended.co.uk ([217.204.248.2]:50832 "EHLO fw.tomsflat")
	by vger.kernel.org with ESMTP id <S289120AbSANWli>;
	Mon, 14 Jan 2002 17:41:38 -0500
Date: Mon, 14 Jan 2002 22:41:35 +0000
From: Tom Gilbert <tom@linuxbrit.co.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery -- the elegant solution)
Message-ID: <20020114224135.H9555@ummagumma>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	"Eric S. Raymond" <esr@thyrsus.com>
In-Reply-To: <20020114125228.B14747@thyrsus.com> <E16QBwD-0002So-00@the-village.bc.nu> <20020114132618.G14747@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020114132618.G14747@thyrsus.com>
User-Agent: Mutt/1.3.23i
X-Editor: Vim http://www.vim.org/
X-Info: http://www.linuxbrit.co.uk
Organisation: Poor
X-Operating-System: Linux/2.4.10-ac9 (i686)
X-Uptime: 22:38:09 up 34 days,  4:09,  5 users,  load average: 0.04, 0.03, 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Eric S. Raymond (esr@thyrsus.com) wrote:
> Alan Cox <alan@lxorguk.ukuu.org.uk>:
> > Now to do everything you describe does not need her to configure a custom
> > kernel tree. Not one bit. You think apt or up2date build each user a custom
> > kernel tree ?
> 
> Is it OK in your world that Aunt Tillie is dependent on a distro maker?  Is
> it OK that she never gets to have a kernel compiled for anything above the
> least-common-denominator chip?  

$ apt-cache search kernel-image | grep 2.4.17
kernel-image-2.4.17-386 - Linux kernel image for version 2.4.17 on 386.
kernel-image-2.4.17-586tsc - Linux kernel image for version 2.4.17 on
Pentium-Classic.
kernel-image-2.4.17-686 - Linux kernel image for version 2.4.17 on
PPro/Celeron/PII/PIII.
kernel-image-2.4.17-686-smp - Linux kernel image 2.4.17 on
PPro/Celeron/PII/PIII SMP.
kernel-image-2.4.17-k6 - Linux kernel image for version 2.4.17 on AMD
K6/K6-II/K6-III
kernel-image-2.4.17-k7 - Linux kernel image for version 2.4.17 on AMD K7
pcmcia-modules-2.4.17-386 - PCMCIA Modules for Linux (kernel
2.4.17-386).

Aunt Tillie's distro autodetects her processor type and installs the
appropriate image. Aunt Tillie's distro provides precompiled,
preconfigured, modular kernels which require no configuration. Aunt
Tillie clicks on the "check for software updates" icon on her desktop
and her distro installs security fixes, new software, and a new kernel.

Aunt Tillie doesn't even have to _know_ she needs a better VM.
 
> But the point of this game is for Aunt Tillie to have more and better
> choices.  Isn't that what we're supposed to be about?

$ apt-cache search kernel-image | wc -l      
     49

Tom.
-- 
   .^.    .-------------------------------------------------------.
   /V\    | Tom Gilbert, London, England | http://linuxbrit.co.uk |
 /(   )\  | Open Source/UNIX consultant  | tom@linuxbrit.co.uk    |
  ^^-^^   `-------------------------------------------------------'
