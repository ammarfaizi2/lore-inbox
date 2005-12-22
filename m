Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932231AbVLVNhh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbVLVNhh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 08:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbVLVNhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 08:37:37 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:21943 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932231AbVLVNhh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 08:37:37 -0500
Date: Thu, 22 Dec 2005 14:35:07 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 1/6] RTC subsystem, class
Message-ID: <20051222133507.GA10208@elf.ucw.cz>
References: <20051220214511.12bbb69c@inspiron>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051220214511.12bbb69c@inspiron>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> rtc/class.c - registration facilities for RTC drivers
> rtc/intf.c - kernel/rtc interface functions 
> rtc/utils.c - misc rtc-related utility functions

> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-nslu2/drivers/rtc/intf.c	2005-12-15 09:28:14.000000000 +0100
> @@ -0,0 +1,67 @@

interface.c, please.


> +/*
> + * rtc-intf.c - rtc subsystem, interface functions

Wrong filename.

> +int rtc_set_alarm(struct class_device *class_dev, struct rtc_wkalrm*alrm)

Struct rtc_wake_alarm *alarm, those wovels are there for readability.

-- 
Thanks, Sharp!
