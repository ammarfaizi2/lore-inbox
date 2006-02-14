Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030496AbWBNIQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030496AbWBNIQw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 03:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030511AbWBNIQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 03:16:52 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:27335 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1030496AbWBNIQv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 03:16:51 -0500
Date: Tue, 14 Feb 2006 09:16:11 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
cc: smartmontools-support@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: WD 400GB SATA Drive In Constant Smart Testing?
In-Reply-To: <Pine.LNX.4.64.0602130524350.13160@p34>
Message-ID: <Pine.LNX.4.61.0602140915030.7198@yvahk01.tjqt.qr>
References: <Pine.LNX.4.64.0602130524350.13160@p34>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Is there some sort of smart testing going on constantly?  I only get 26-27MB/s

You can find out using `smartctl -data -a /dev/hdX`; if there is a SMART 
test going on, there should be info about its status.

> #13  Vendor offline      Completed without error       00%         0 -
> #14  Offline             Completed without error       00%         0 -
> #15  Offline             Completed without error       00%         0 -
> #16  Offline             Completed without error       00%         0 -
> #17  Offline             Completed without error       00%         0 -
> #18  Offline             Completed without error       00%         0 -
> #19  Offline             Completed without error       00%         0 -
> #20  Offline             Completed without error       00%         0 -
> #21  Offline             Completed without error       00%         1 -
>
A little bit more below the values, usually.



Jan Engelhardt
-- 
