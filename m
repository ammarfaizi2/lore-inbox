Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751390AbWBZSlx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbWBZSlx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 13:41:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbWBZSlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 13:41:53 -0500
Received: from mx0.towertech.it ([213.215.222.73]:53462 "HELO mx0.towertech.it")
	by vger.kernel.org with SMTP id S1751390AbWBZSlw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 13:41:52 -0500
Date: Sun, 26 Feb 2006 19:41:16 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>, Russell King <rmk@arm.linux.org.uk>
Subject: Re: 2.6.16-rc4-mm2: drivers/rtc/utils.c should become part of a
 generic implementation
Message-ID: <20060226194116.50f7ad2e@inspiron>
In-Reply-To: <20060225131025.GK3674@stusta.de>
References: <20060224031002.0f7ff92a.akpm@osdl.org>
	<20060225033118.GF3674@stusta.de>
	<20060225054619.149db264@inspiron>
	<20060225131025.GK3674@stusta.de>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Feb 2006 14:10:25 +0100
Adrian Bunk <bunk@stusta.de> wrote:

> 
> Sounds good, but for generic functions, two adjustments are required:
> - move the code to lib/
> - remove rtc_ prefixes from the functions

 Moved. I'm not sure about renaming them.. 

 the functions are:

rtc_month_days
rtc_time_to_tm
rtc_valid_tm
rtc_tm_to_time

 I think they make more sense with the rtc prefix

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

