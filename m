Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312446AbSDSNYE>; Fri, 19 Apr 2002 09:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312447AbSDSNYD>; Fri, 19 Apr 2002 09:24:03 -0400
Received: from [203.135.39.218] ([203.135.39.218]:15370 "EHLO ns1.giki.edu.pk")
	by vger.kernel.org with ESMTP id <S312446AbSDSNYD>;
	Fri, 19 Apr 2002 09:24:03 -0400
Message-ID: <002a01c1e749$9901b7a0$e53ca8c0@hostel6.resnet.giki.edu.pk>
From: "Jehanzeb Hameed" <u990056@giki.edu.pk>
To: "Trond Myklebust" <trond.myklebust@fys.uio.no>
Cc: "Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0204181338050.19147-100000@penguin.transmeta.com> <shs7kn4m3mk.fsf@charged.uio.no> <004801c1e740$3edb09b0$e53ca8c0@hostel6.resnet.giki.edu.pk> <E16yXRh-0005k9-00@charged.uio.no>
Subject: Re: regarding NFS
Date: Thu, 18 Apr 2002 19:26:22 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-ECS-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> No. inode->i_mapping is initialized by the VFS, not the NFS client 
> filesystem. (see linux/fs/inode.c:clean_inode())
> 
> Cheers,
>   Trond
> 

but then why does RAMFS assign it..??

