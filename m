Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316590AbSEPGwj>; Thu, 16 May 2002 02:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316591AbSEPGwi>; Thu, 16 May 2002 02:52:38 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:63646 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S316590AbSEPGwh>;
	Thu, 16 May 2002 02:52:37 -0400
Date: Thu, 16 May 2002 16:51:50 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Ben Greear <greearb@candelatech.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: APM hangs during boot w/out keyboard plugged in.
Message-Id: <20020516165150.157e142b.sfr@canb.auug.org.au>
In-Reply-To: <3CDD5DF3.8030306@candelatech.com>
X-Mailer: Sylpheed version 0.7.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

On Sat, 11 May 2002 11:07:47 -0700 Ben Greear <greearb@candelatech.com> wrote:
>
> I have noticed that the APM initialization always hangs when I
> try to boot my various machines w/out the keyboard plugged in.
> 
> This is true of many kernels, including the one shipped with RH 7.3.
> 
> For now, I have to re-compile the kernel w/out APM support.  Is
> there some fundamental problem with using APM w/out a keyboard,
> or can the code be fixed?
> 
> My motherboard is Intel EEA2, 815 chipset.  If more information
> will help, please let me know and I'll provide it.

This sounds like a probelm with the BIOS on your computer.  The apm
driver in the kernel has no dependencies on the keyboard.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
