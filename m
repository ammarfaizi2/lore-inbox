Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262538AbTJGRPi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 13:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262539AbTJGRPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 13:15:38 -0400
Received: from mcomail03.maxtor.com ([134.6.76.14]:18700 "EHLO
	mcomail03.maxtor.com") by vger.kernel.org with ESMTP
	id S262538AbTJGRPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 13:15:37 -0400
Message-ID: <785F348679A4D5119A0C009027DE33C105CDB216@mcoexc04.mlm.maxtor.com>
From: "Mudama, Eric" <eric_mudama@Maxtor.com>
To: "'linuxcompilerdd'" <linuxcompiler@yahoo.es>, linux-kernel@vger.kernel.org
Subject: RE: hello, i need some help
Date: Tue, 7 Oct 2003 11:15:36 -0600 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.xx I obtain this error:
VFS:cannot open root device "hdb5" or hdb5


That is the message I got when I made my filesystem (ext2) a module instead
of built in, but I didn't have an initrd setup properly.

Try compiling your filesystem support for the boot device into the kernel.



> -----Original Message-----
> From: linuxcompilerdd [mailto:linuxcompiler@yahoo.es]
> Sent: Tuesday, October 07, 2003 10:36 AM
> To: linux-kernel@vger.kernel.org
> Subject: hello, i need some help
> 
> 
> Hello,
> 
> I have a problem booting the kernel.
> Now i am using kernel 2.4.20 and it is working nice but when 
> I try to boot
> 2.5.xx I obtain this error:
> VFS:cannot open root device "hdb5" or hdb5
> 
> After working on it, now I am sure that the problem is on the 
> hard disk because
> I have an AWARD 4.51 and my hdb is an 60Gb disk so I use the 
> STROKE from SEAGATE 
> to use it.
> I don`t have any problem on 2.x.xx but I cannot boot on it now.
> I have booted the same kernel that displayed the error in 
> other system and
> it booted perfectly, so the problem resides on the hdb.
> 
> I wish you could help me resolving it, maybe a patch for the drive...
> 
> I hope your answer.
> Thank u
> 
> Guille
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
