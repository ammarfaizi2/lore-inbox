Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbVKRPTg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbVKRPTg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 10:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbVKRPTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 10:19:35 -0500
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:42652 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1750834AbVKRPTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 10:19:34 -0500
Date: Fri, 18 Nov 2005 10:19:33 -0500
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Giuliano Pochini <pochini@shiny.it>, alex@alexfisher.me.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Jeff V. Merkey" <jmerkey@utah-nac.org>,
       Michael Buesch <mbuesch@freenet.de>
Subject: Re: Would I be violating the GPL?
Message-ID: <20051118151932.GH9488@csclub.uwaterloo.ca>
References: <XFMail.20051102104916.pochini@shiny.it> <Pine.LNX.4.61.0511102002160.17092@yvahk01.tjqt.qr> <20051110191244.GG9488@csclub.uwaterloo.ca> <Pine.LNX.4.61.0511172221580.4792@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0511172221580.4792@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2005 at 10:23:21PM +0100, Jan Engelhardt wrote:
> Building for VMware Workstation 5.0.0.

Well I only looked at 4.5.2

> Using 2.6.x kernel build system.
> make -C /lib/modules/2.6.13-AS20/build/include/.. SUBDIRS=$PWD 
> SRCROOT=$PWD/. modules
>   CC [M]  /usr/lib/vmware/modules/source/vmmon-only/linux/driver.o
>   CC [M]  /usr/lib/vmware/modules/source/vmmon-only/linux/hostif.o
>   CC [M]  /usr/lib/vmware/modules/source/vmmon-only/common/cpuid.o
>   CC [M]  /usr/lib/vmware/modules/source/vmmon-only/common/hash.o
>   CC [M]  /usr/lib/vmware/modules/source/vmmon-only/common/memtrack.o
>   CC [M]  /usr/lib/vmware/modules/source/vmmon-only/common/phystrack.o
>   CC [M]  /usr/lib/vmware/modules/source/vmmon-only/common/task.o
> cc1plus: warning: command line option "-Wstrict-prototypes" is valid for 
> Ada/C/ObjC but not for C++
> cc1plus: warning: command line option 
> "-Werror-implicit-function-declaration" is valid for C/ObjC but not for C++
> cc1plus: warning: command line option "-Wdeclaration-after-statement" is 
> valid for C/ObjC but not for C++
> cc1plus: warning: command line option "-Wno-pointer-sign" is valid for 
> C/ObjC but not for C++
> cc1plus: warning: command line option "-Wstrict-prototypes" is valid for 
> Ada/C/ObjC but not for C++
> cc1plus: warning: command line option "-ffreestanding" is valid for C/ObjC 
> but not for C++
> include/asm/bitops.h: In function ???int find_first_bit(const long unsigned 
> int*,
> unsigned int)???:
> include/asm/bitops.h:334: warning: comparison between signed and unsigned 
> integer expressions
> [...]

Whyever is anything calling cc1plus when the file appear to all be .c?

Len Sorensen
