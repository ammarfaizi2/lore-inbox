Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932668AbWB1Xtp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932668AbWB1Xtp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 18:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932697AbWB1Xtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 18:49:45 -0500
Received: from mx0.towertech.it ([213.215.222.73]:49807 "HELO mx0.towertech.it")
	by vger.kernel.org with SMTP id S932668AbWB1Xtp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 18:49:45 -0500
Date: Wed, 1 Mar 2006 00:49:20 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: Mattia Dongili <malattia@linux.it>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc5-mm1
Message-ID: <20060301004920.6fa64401@inspiron>
In-Reply-To: <20060228204850.GB4286@inferi.kami.home>
References: <20060228042439.43e6ef41.akpm@osdl.org>
	<20060228204850.GB4286@inferi.kami.home>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Feb 2006 21:48:50 +0100
Mattia Dongili <malattia@linux.it> wrote:

> in drives/Makefile the line
> 
> obj-$(CONFIG_RTC_CLASS)		+= /rtc
> 
> causes the missing symbols
> WARNING: /lib/modules/2.6.16-rc5-mm1-1/kernel/drivers/rtc/rtc-test.ko needs unknown symbol rtc_time_to_tm
> WARNING: /lib/modules/2.6.16-rc5-mm1-1/kernel/drivers/rtc/rtc-core.ko needs unknown symbol rtc_valid_tm
> WARNING: /lib/modules/2.6.16-rc5-mm1-1/kernel/drivers/rtc/rtc-sysfs.ko needs unknown symbol rtc_tm_to_tim
> 
> when CONFIG_RTC_*=m. Maybe obj-y is nedded instead?


 Hi,

  thanks. It is now fixed as a side effect of another patch. I expect
 to release the new version in a couple of days.

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

