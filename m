Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283603AbRLWFJe>; Sun, 23 Dec 2001 00:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283594AbRLWFJX>; Sun, 23 Dec 2001 00:09:23 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:5131 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S283591AbRLWFJP>;
	Sun, 23 Dec 2001 00:09:15 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Jeremy Drake <jeremyd@apptechsys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Undefined symbol in nfsd.o kernel 2.4.17 
In-Reply-To: Your message of "Sat, 22 Dec 2001 19:49:55 -0800."
             <Pine.LNX.4.33L2.0112221937190.21842-100000@eiger.apptechsys.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 23 Dec 2001 16:09:03 +1100
Message-ID: <22246.1009084143@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Dec 2001 19:49:55 -0800 (PST), 
Jeremy Drake <jeremyd@apptechsys.com> wrote:
>I am getting an undefined symbol in nfsd.o in kernel 2.4.17.  The message
>is "/lib/modules/2.4.17/kernel/fs/nfsd/nfsd.o: unresolved symbol
>nfsd_linkage".  Nfsd works fine when linked into the kernel.
>I was able to make it work by changing "EXPORT_SYMBOL(nfsd_linkage);" in
>fs/filesystems.c to "EXPORT_SYMBOL_NOVERS(nfsd_linkage);".  Not sure if
>that's the proper way to go about it, but it works :)

http://www.tux.org/lkml/#s8-8

