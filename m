Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264694AbRFQHsd>; Sun, 17 Jun 2001 03:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264695AbRFQHsX>; Sun, 17 Jun 2001 03:48:23 -0400
Received: from 202-54-39-145.tatainfotech.co.in ([202.54.39.145]:32016 "EHLO
	brelay.tatainfotech.com") by vger.kernel.org with ESMTP
	id <S264694AbRFQHsF>; Sun, 17 Jun 2001 03:48:05 -0400
Date: Sun, 17 Jun 2001 13:36:58 +0530 (IST)
From: "SATHISH.J" <sathish.j@tatainfotech.com>
To: linux-kernel@vger.kernel.org
Subject: Reg:dentry->d_mounts value
In-Reply-To: <Pine.LNX.4.10.10106151546310.5980-100000@blrmail>
Message-ID: <Pine.LNX.4.10.10106171329390.10824-100000@blrmail>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry to disturb you all.

In the d_alloc() function in the vfs layer of the filesystem(2.2.14
kernel) we can see the following: 

        dentry->d_mounts = dentry;
        dentry->d_covers = dentry;
        
Why should both the above be assigned the values of dentry. Wher elase is
this used. Please help me with this information. 

Thanks in advance,
Regards,
sathish.j

