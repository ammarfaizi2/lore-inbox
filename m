Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266619AbUI2Fys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266619AbUI2Fys (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 01:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268207AbUI2Fys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 01:54:48 -0400
Received: from [220.225.128.84] ([220.225.128.84]:2537 "HELO
	mail.gdatech.co.in") by vger.kernel.org with SMTP id S266619AbUI2Fyp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 01:54:45 -0400
Message-ID: <001c01c4a5e9$114bf490$8200a8c0@RakeshJagota>
From: "Rakesh Jagota" <j.rakesh@gdatech.co.in>
To: "Jeff Garzik" <jgarzik@pobox.com>
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
       <kernelnewbies@nl.linux.org>
References: <4159E85A.6080806@ammasso.com> <006001c4a5df$ad605c40$8200a8c0@RakeshJagota> <415A4151.7060301@pobox.com>
Subject: Re: opening a file inside the kernel module
Date: Wed, 29 Sep 2004 11:26:30 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Thnx.

I want to implement socket from the module. I won't be having any user
process running to handle the descriptors coming from socket. Could you pl
tell me how to handle the socket descriptor from the kernel module.

Thanks,
rakesh
----- Original Message -----
From: "Jeff Garzik" <jgarzik@pobox.com>
To: "Rakesh Jagota" <j.rakesh@gdatech.co.in>
Cc: <linux-mm@kvack.org>; <linux-kernel@vger.kernel.org>;
<kernelnewbies@nl.linux.org>
Sent: Wednesday, September 29, 2004 10:30 AM
Subject: Re: opening a file inside the kernel module


> Rakesh Jagota wrote:
> > Hi all,
> > I am working in linux, i would like to know abt whether can I open a
file
> > inside the kernel module without using any application. If so how how
the
> > files_struct will be maintained. Does a kernel module has this struct?
>
> Don't do this.  It's incompatible with namespaces.
>
> Instead, figure out some way to pass the file contents to the kernel
module.
>
> Jeff
>
>
>
> --
> Kernelnewbies: Help each other learn about the Linux kernel.
> Archive:       http://mail.nl.linux.org/kernelnewbies/
> FAQ:           http://kernelnewbies.org/faq/
>
>

