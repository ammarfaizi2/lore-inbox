Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286262AbRLTOPb>; Thu, 20 Dec 2001 09:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286261AbRLTOPN>; Thu, 20 Dec 2001 09:15:13 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:42766 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S286260AbRLTOO7>;
	Thu, 20 Dec 2001 09:14:59 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Rasmus Andersen <rasmus@jaquet.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.17-rc2 
In-Reply-To: Your message of "Thu, 20 Dec 2001 13:44:33 BST."
             <20011220134433.Q825@jaquet.dk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 21 Dec 2001 01:14:47 +1100
Message-ID: <24612.1008857687@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Dec 2001 13:44:33 +0100, 
Rasmus Andersen <rasmus@jaquet.dk> wrote:
>Compiling rc2 I get the following:
>
>make[1]: Leaving directory `/home/rasmus/kernel/linux-2417r2/arch/i386/math-emu'
>gcc  -D__KERNEL__ -I/home/rasmus/kernel/linux-2417r2/include -e stext  arch/i386/vmlinux.lds.S   -o arch/i386/vmlinux.lds

-rc2 does not have arch/i386/vmlinux.lds.S, only arch/i386/vmlinux.lds.
You have picked up vmlinux.lds.S from somewhere and it is confusing
make.

