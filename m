Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315616AbSEJMbM>; Fri, 10 May 2002 08:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315738AbSEJMbL>; Fri, 10 May 2002 08:31:11 -0400
Received: from imr1.ericy.com ([208.237.135.240]:6365 "EHLO imr1.ericy.com")
	by vger.kernel.org with ESMTP id <S315616AbSEJMbK>;
	Fri, 10 May 2002 08:31:10 -0400
Message-ID: <3CDB689A.F43BD31@edb.ericsson.se>
Date: Fri, 10 May 2002 09:28:42 +0300
From: Christian Burger <christian.burger@edb.ericsson.se>
Reply-To: christian.burger@edb.ericsson.se
Organization: Ericsson
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Jussi Laako <jussi.laako@kolumbus.fi>, linux-kernel@vger.kernel.org
Subject: Re: fonts corruption with 3dfx drm module
In-Reply-To: <3CDA61CA.498991DF@edb.ericsson.se> <3CDADD92.908001AB@kolumbus.fi>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does anyone know how to trace this problem to check if it's related to tdfx?
I think there are two modules for tdfx, one created for the DRI tree of X and
one created from the kernel.
I don't know which we are supposed to use.
Besides this, I believe glide3.so.xxx library interacts with this part of the
code, so it might also be a reason for the problem.
Anyone knows how to investigate this further? Does this make any sense?
Thanks, 

	Christian Burger
  

Jussi Laako wrote:
> 
> Christian Burger wrote:
> >
> > I've seen a much more serious problem which seems to be related to this:
> > I have AMD Athlon K7 650MHz, Via chipset, Voodoo5 5500AGP, MTTR enabled.
> > What is happening here is that when switching back from init 5 to init 3
> > for instance, the system hangs completely and a blinking character
> > appears in a black screen. There's no other way other than to power cycle
> > the system. It seems to be a kernel panic.
> > Kernel version is 2.4.18, and it happens with or without DRM support,
> > with and without FB support. There's no way I can have this version of
> > the kernel to work here.
> 
> Same problem here, with AMD K6 and Voodoo3 2000 PCI. All kernels and all
> XFree86 4.x.x versions. Although it doesn't hang the machine. Usually just
> fonts in vc1 are messed up.
> 
> So, it's not MTRR nor AGP problem. It must be something in XFree86 tdfx
> driver. Accelerated-X doesn't show this problem.
> 
>         - Jussi Laako
> 
> --
> PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
> Available at PGP keyservers
