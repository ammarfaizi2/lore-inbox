Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264298AbRFOKFB>; Fri, 15 Jun 2001 06:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264318AbRFOKEv>; Fri, 15 Jun 2001 06:04:51 -0400
Received: from 202-54-39-145.tatainfotech.co.in ([202.54.39.145]:56846 "EHLO
	brelay.tatainfotech.com") by vger.kernel.org with ESMTP
	id <S264298AbRFOKEl>; Fri, 15 Jun 2001 06:04:41 -0400
Date: Fri, 15 Jun 2001 15:52:52 +0530 (IST)
From: "SATHISH.J" <sathish.j@tatainfotech.com>
To: linux-kernel@vger.kernel.org
Subject: Reg file system hash function
In-Reply-To: <Pine.LNX.4.10.10106141549470.11393-100000@blrmail>
Message-ID: <Pine.LNX.4.10.10106151546310.5980-100000@blrmail>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In the vfs layer when we see the lookup_dentry() function code we see that
a part of the code checks whether low level filesystem wants to use its
own hash. the part odf the code that calls the filesystem dependant
hashing is  "error = base->d_op->d_hash->(base,&this);". Why should it
callfilesystem dependant hashing. What is the main purpose of hashing
here.
Please help me with these details. 

Thanks in advance,
Regards,
sathish.j
 


