Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbVLZTT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbVLZTT0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 14:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932112AbVLZTTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 14:19:25 -0500
Received: from smtp7.libero.it ([193.70.192.90]:22170 "EHLO smtp7.libero.it")
	by vger.kernel.org with ESMTP id S932113AbVLZTTY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 14:19:24 -0500
Date: Mon, 26 Dec 2005 03:47:54 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 1/6] RTC subsystem, class
Message-ID: <20051226034754.1fdfc393@inspiron>
In-Reply-To: <20051222133507.GA10208@elf.ucw.cz>
References: <20051220214511.12bbb69c@inspiron>
	<20051222133507.GA10208@elf.ucw.cz>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned: with antispam and antivirus automated system at libero.it
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Dec 2005 14:35:07 +0100
Pavel Machek <pavel@ucw.cz> wrote:

> > --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> > +++ linux-nslu2/drivers/rtc/intf.c	2005-12-15 09:28:14.000000000 +0100
> > @@ -0,0 +1,67 @@
> 
> interface.c, please.

 ack.

> > +/*
> > + * rtc-intf.c - rtc subsystem, interface functions
> 
> Wrong filename.

 ok, I removed all filenames :)
 
> > +int rtc_set_alarm(struct class_device *class_dev, struct rtc_wkalrm*alrm)
> 
> Struct rtc_wake_alarm *alarm, those wovels are there for readability.

 I'm not the one who created this structure. It's defined
 in linux/rtc.h since a long time. I can only change alrm
 to alarm.

 thanks!

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

