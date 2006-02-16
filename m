Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932237AbWBPDre@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbWBPDre (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 22:47:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbWBPDre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 22:47:34 -0500
Received: from web32111.mail.mud.yahoo.com ([68.142.207.125]:37256 "HELO
	web32111.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932237AbWBPDrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 22:47:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Nj47aGjkpU1Os+pEdmcrDENRsNcMkobN7+fKK3P1TFd5VKvRj+J60Wf7IElNVA0XqK6qjclPalBN2FAIMHEAdpJ0X5JbxIbaVSKEThqprXU9DkJY4FjIBBchrlZwLk68p6ksTe8are2I/lE44drwEtJXQ5baQdTLK1dZIfNEr/U=  ;
Message-ID: <20060216034732.86167.qmail@web32111.mail.mud.yahoo.com>
Date: Wed, 15 Feb 2006 19:47:32 -0800 (PST)
From: shivani kirubanandan <k_shivanii@yahoo.com>
Subject: error during kernel compilation for xilinx ml300 specific kernel
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello

I downloaded the ppc-devel kernel from bitkeeper.com
I am trying to build a kernel for the xilinx specific
env I have already built the cross compiler and
changed the main make file to
ARCH=ppc
CROSS-COMPILE = powerpc-405-linux-gnu-

but am encountering the following error

[root@localhost linux-2.4.26]# make zImage
scripts/split-include include/linux/autoconf.h
include/config
powerpc-405-linux-gnu-gcc -D__KERNEL__
-I/home/shivani/downloads/crosstool-0.38/build/powerpc-405-linux-gnu/gcc-3.3.2-glibc-2.3.2/linux-2.4.26/include
-Wall -Wstrict-prototypes -Wno-trigraphs -O2
-fno-strict-aliasing -fno-common -fomit-frame-pointer
-I/home/shivani/downloads/crosstool-0.38/build/powerpc-405-linux-gnu/gcc-3.3.2-glibc-2.3.2/linux-2.4.26/arch/ppc
-fsigned-char -msoft-float -pipe -ffixed-r2
-Wno-uninitialized -mmultiple -mstring -Wa,-m405  
-DKBUILD_BASENAME=main -c -o init/main.o init/main.c
make: powerpc-405-linux-gnu-gcc: Command not found
make: *** [init/main.o] Error 127

the gcc files are present in
opt/crosstool/gcc-3.3.2-glibc-2.3.2/powerpc-405-linux-gnu

and the bin folder holds the binaries too..since cross
compilation has been done properly i dont know how
this error occurs
my kernel is present in
/home/shivani/downloads/linux-2.4.26


plz help me out on this error

regards
shivani



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
