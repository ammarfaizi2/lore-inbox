Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314470AbSDRVrV>; Thu, 18 Apr 2002 17:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314474AbSDRVrU>; Thu, 18 Apr 2002 17:47:20 -0400
Received: from [203.135.39.218] ([203.135.39.218]:58377 "EHLO ns1.giki.edu.pk")
	by vger.kernel.org with ESMTP id <S314470AbSDRVrC>;
	Thu, 18 Apr 2002 17:47:02 -0400
Message-ID: <001f01c1e6c6$2d6a9f80$e53ca8c0@hostel6.resnet.giki.edu.pk>
From: "Jehanzeb Hameed" <u990056@giki.edu.pk>
To: "Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0204181338050.19147-100000@penguin.transmeta.com>
Subject: regarding NFS
Date: Thu, 18 Apr 2002 03:45:38 -0700
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

I was looking at the code  and I couldnt find how NFS implements
inode->i_mapping->a_ops->readpage(filp,page) in
used by generic_file_read in mm/filemapc.c. All I could find was
inode->i_op->readpage(filp,page). But NFS uses generic_file_read....so how
does it work out. Kernel 2.4.17??

Jehanzeb

