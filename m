Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932130AbVLZURi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbVLZURi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 15:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbVLZURi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 15:17:38 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2224 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932130AbVLZURi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 15:17:38 -0500
Date: Mon, 26 Dec 2005 21:16:57 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH 1/6] RTC subsystem, class
Message-ID: <20051226201657.GA1974@elf.ucw.cz>
References: <20051220214511.12bbb69c@inspiron> <20051222133507.GA10208@elf.ucw.cz> <20051226034754.1fdfc393@inspiron>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051226034754.1fdfc393@inspiron>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > +int rtc_set_alarm(struct class_device *class_dev, struct rtc_wkalrm*alrm)
> > 
> > Struct rtc_wake_alarm *alarm, those wovels are there for readability.
> 
>  I'm not the one who created this structure. It's defined
>  in linux/rtc.h since a long time. I can only change alrm
>  to alarm.

Sorry if you are not responsible... Yes, alarm would be better.

How does this relate to /proc/acpi/alarm, btw? Do they use same RTC
alarm?


							Pavel
-- 
Thanks, Sharp!
