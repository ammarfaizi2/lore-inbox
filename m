Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135508AbRD3Q02>; Mon, 30 Apr 2001 12:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135509AbRD3Q0S>; Mon, 30 Apr 2001 12:26:18 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:777 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135508AbRD3QZ6>; Mon, 30 Apr 2001 12:25:58 -0400
Subject: Re: DMI deactivated - why?
To: reinelt@eunet.at (Michael Reinelt)
Date: Mon, 30 Apr 2001 17:27:30 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <3AED016D.5D77F29E@eunet.at> from "Michael Reinelt" at Apr 30, 2001 08:08:45 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14uGWM-0008Gi-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It should print some DMI values at boot. As far as I remember, I've seen
> these at times of 2.4.0 or so. Now these outputs are deactivated with a 
> #define dmi_printk(x)
> 
> Can someone explain why this has been deactivated? I would find these
> values quite useful!

They take up a lot of boot log space and you can recover them later. Take a 
look at dmiscan.c on
	ftp://ftp.linux.org.uk/pub/linux/alan/
