Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310906AbSCHPRm>; Fri, 8 Mar 2002 10:17:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310908AbSCHPRc>; Fri, 8 Mar 2002 10:17:32 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:26892 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310906AbSCHPRV>; Fri, 8 Mar 2002 10:17:21 -0500
Subject: Re: Interprocess shared memory .... but file backed?
To: cq@htec.demon.co.uk (Christopher Quinn)
Date: Fri, 8 Mar 2002 15:32:39 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, cq@htec.demon.co.uk (Christopher Quinn)
In-Reply-To: <3C88D3F2.40807@htec.demon.co.uk> from "Christopher Quinn" at Mar 08, 2002 03:08:34 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16jMMJ-0006V3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> However as far as I can tell this is anonymous memory only.
> Are there any options if one initially maps a disk file via 
> mmap (in particular MAP_PRIVATE) for sharing that vm, such 

well MAP_PRIVATE is "dont share" so not with that 8)
Use MAP_SHARED and you'll get what you want
