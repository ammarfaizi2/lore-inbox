Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275042AbRJUBPk>; Sat, 20 Oct 2001 21:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275067AbRJUBPa>; Sat, 20 Oct 2001 21:15:30 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:54022 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S275042AbRJUBPR>;
	Sat, 20 Oct 2001 21:15:17 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Stuart Luscombe <stuart@ubersecksie.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compilation of 2.4.0 fails when processing /i386/boot 
In-Reply-To: Your message of "Sat, 20 Oct 2001 23:11:31 GMT."
             <20011020231131.A4560@ubersecksie.co.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 21 Oct 2001 11:15:39 +1000
Message-ID: <4498.1003626939@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Oct 2001 23:11:31 +0000, 
Stuart Luscombe <stuart@ubersecksie.co.uk> wrote:
>I am compiling kernel 2.4.0, and I am getting the following error
>during the 'make install' part of the build:
>ld -m elf_i386 -Ttext 0x0 -s -oformat binary bbootsect.o -o bbootsect
>make[1]: Leaving directory `/usr/src/linux/arch/i386/boot'
>ld: cannot open binary: No such file or directory

New binutils on an old kernel.  Change -oformat to --oformat.

