Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263363AbTDGJJk (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 05:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263364AbTDGJJk (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 05:09:40 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:16343 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S263363AbTDGJJj (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 05:09:39 -0400
Subject: Re: registration function of Cardbus driver
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Prasanta Sadhukhan <prasanta@tataelxsi.co.in>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E913335.96D0DAEA@tataelxsi.co.in>
References: <3E913335.96D0DAEA@tataelxsi.co.in>
Content-Type: text/plain
Organization: 
Message-Id: <1049707222.592.17.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 07 Apr 2003 11:20:57 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-04-07 at 10:13, Prasanta Sadhukhan wrote:
> Hi,
>     Our Cardbus driver was using register_driver/unregister_driver
> function  of cb_enabler.c    for registration and unregistration in
> RH7.1
> But in RH 8.0 , we are not able to find cb_enabler.o file in
> /modules/pcmcia directory even when we compile the kernel with PCMCIA
> CARDBUS support.

If my memory serves me well, you need an external project named
"pcmcia-cs" that you can download from http://pcmcia-cs.sourceforge.net.
This project has alternative PCMCIA/CardBus support and it has the
cb_enabler module you're looking for.

Linux Registered User #287198

