Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265085AbSLQO0o>; Tue, 17 Dec 2002 09:26:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265081AbSLQO0o>; Tue, 17 Dec 2002 09:26:44 -0500
Received: from chaos.analogic.com ([204.178.40.224]:39306 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S265085AbSLQO0n>; Tue, 17 Dec 2002 09:26:43 -0500
Date: Tue, 17 Dec 2002 09:36:26 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: =?iso-8859-1?q?Sanjay=20Kumar?= <sanju93csd@yahoo.co.in>
cc: linux-kernel@vger.kernel.org, Matt_Domsch@dell.com
Subject: Re: How to get the size of the block device ???? (Important)
In-Reply-To: <20021217142247.18564.qmail@web8206.mail.in.yahoo.com>
Message-ID: <Pine.LNX.3.95.1021217093512.24416A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Dec 2002, [iso-8859-1] Sanjay Kumar wrote:

> Hi,
>   I am Sanjay Kumar and wants to write my own file
> system on Linux. I have almost written the code.
>   But,now i have a problem while writing the code 
> for "mkfs" for my filesystem.
> 
> Problem Summary : I need the size of the block device
> in bytes on which my file system will be created.
> Actually, there is a feild in the super block, needs
> the total no of blocks on the device while while
> creating the filesystem. So, Can you Plz. help me out
> of this problem.
> 

You make an ioctl() function for your file-system that returns
the block-size that you selected when you designed the system.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


