Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317407AbSFLHzM>; Wed, 12 Jun 2002 03:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317665AbSFLHzL>; Wed, 12 Jun 2002 03:55:11 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:50692 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S317407AbSFLHzJ>; Wed, 12 Jun 2002 03:55:09 -0400
Subject: Re: NFS Client mis-behaviour?
To: simon@paxonet.com (Simon Matthews)
Date: Wed, 12 Jun 2002 09:16:57 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0206102041020.11116-100000@spare> from "Simon Matthews" at Jun 10, 2002 08:48:22 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17I3JJ-0007AN-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Another question: this system has 2 CPUs, yet the kernel detects 4. Any 
> ideas why? 

Hypedthreading - new xeons appear as 2 cpus and one execution path can
make use of execution resources when the other stalls.
