Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312427AbSDSMRP>; Fri, 19 Apr 2002 08:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312444AbSDSMRO>; Fri, 19 Apr 2002 08:17:14 -0400
Received: from [203.135.39.218] ([203.135.39.218]:37637 "EHLO ns1.giki.edu.pk")
	by vger.kernel.org with ESMTP id <S312427AbSDSMRO>;
	Fri, 19 Apr 2002 08:17:14 -0400
Message-ID: <004801c1e740$3edb09b0$e53ca8c0@hostel6.resnet.giki.edu.pk>
From: "Jehanzeb Hameed" <u990056@giki.edu.pk>
To: "Trond Myklebust" <trond.myklebust@fys.uio.no>
Cc: "Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0204181338050.19147-100000@penguin.transmeta.com><001f01c1e6c6$2d6a9f80$e53ca8c0@hostel6.resnet.giki.edu.pk> <shs7kn4m3mk.fsf@charged.uio.no>
Subject: Re: regarding NFS
Date: Thu, 18 Apr 2002 18:19:26 -0700
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


> Look again: there is no such thing as readpage() in the struct
> inode_operations in the 2.4.x kernels. Just grep for 'nfs_file_aops'
> in the source.
> 
> Cheers,
>   Trond
> 

In inode.c inside code for NFS says :
 inode->i_data.a_ops = &nfs_file_aops;

it's still not  "inode->i_mapping->a_ops "!!!!!!

 it should, somewhere, assign something to  inode->i_mapping->a_ops ?????

