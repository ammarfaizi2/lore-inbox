Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135875AbRECSBr>; Thu, 3 May 2001 14:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135879AbRECSAs>; Thu, 3 May 2001 14:00:48 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:12808 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135855AbRECR70>; Thu, 3 May 2001 13:59:26 -0400
Subject: Re: 2.4.4 Kernel - ASUS CUV4X-DLS Question
To: dneal@cnls.lanl.gov (David A. Neal)
Date: Thu, 3 May 2001 19:03:23 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, linux-smp@vger.kernel.org
In-Reply-To: <200105031751.LAA24795@iiwi.lanl.gov> from "David A. Neal" at May 03, 2001 11:51:29 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14vNRm-0005vc-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> trying to solve. I have a system with a ASUS CUV4X-DLS system
> 
> The problem is that the system will boot everytime if and only
> if I use "noapic". If I do not use "noapic", the system will

Known problem with the CUV4X boards. 

> What is the impact on performance by disabling APIC? Is there
> something wrong with the .config file that might fix this.

Disabling the apic stops irq sharing from occuring. The impact is normally
pretty minimal

