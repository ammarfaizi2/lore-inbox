Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbUDJTkf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 15:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbUDJTkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 15:40:35 -0400
Received: from [202.28.93.1] ([202.28.93.1]:54290 "EHLO gear.kku.ac.th")
	by vger.kernel.org with ESMTP id S261682AbUDJTke (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 15:40:34 -0400
Date: Sun, 11 Apr 2004 02:40:38 +0700
From: Kitt Tientanopajai <kitt@gear.kku.ac.th>
To: daniel.ritz@gmx.ch
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5 yenta_socket irq 10: nobody cared!
Message-Id: <20040411024038.409791d7.kitt@gear.kku.ac.th>
In-Reply-To: <200404101814.41955.daniel.ritz@gmx.ch>
References: <200404060227.58325.daniel.ritz@gmx.ch>
	<200404091941.20444.daniel.ritz@gmx.ch>
	<20040410101825.59158e43.kitt@gear.kku.ac.th>
	<200404101814.41955.daniel.ritz@gmx.ch>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> so you say with my first patch both USB ports are working then? so clie sync only
> works on one of the ports but the mouse on both?

I've just tested the usb ports with your first patch again. Now both ports are working, at least for usb mouse, clie sync, and usb storage. So, I think your first patch is okay. Sorry that I did not test them thoroughly at the first time.

> ok, it's the interrupt routing, not the chip config. i think the first patch that
> adds the tm361 to the dmi_scan problem table is correct then. real good
> QA from acer: hack the BIOS, boot it with windows and if it works, ship it...
> it works with windows because it assigned all the devices to the same irq
> 
> i'll submit it later to andrew morton.

Please do so. I hope the patch will be included in 2.6.6. Anyway, thanks again for your help.

rgds,
kitt
