Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312516AbSCUVzl>; Thu, 21 Mar 2002 16:55:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312519AbSCUVzc>; Thu, 21 Mar 2002 16:55:32 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:528 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312516AbSCUVzT>; Thu, 21 Mar 2002 16:55:19 -0500
Subject: Re: 2.4.19-pre4: Compiler crash in i386/kernel/mpparse.c
To: merlim@libero.it
Date: Thu, 21 Mar 2002 22:11:37 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200203212233.07125.lk_ml@libero.it> from "petali grigi" at Mar 21, 2002 10:36:28 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16oAmX-0006Qq-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> gcc crashes compiling arch/i386/kernel/mpparse.c  line 41
> 
> gcc version 3.0.2 20010905 (Red Hat Linux 7.1 3.0.1-3) 
> (the one shipped with RH 7.2)

Use 2.96. gcc 3.0 isnt a good compiler choice for 2.4.x kernels - 3.0.4
seems to be doing the right thing but not 3.0.x x<4. 3.1 snapshots are
also looking very promising
