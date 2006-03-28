Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932098AbWC1Qng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbWC1Qng (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 11:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbWC1Qnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 11:43:35 -0500
Received: from mx0.towertech.it ([213.215.222.73]:19940 "HELO mx0.towertech.it")
	by vger.kernel.org with SMTP id S932098AbWC1Qnf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 11:43:35 -0500
Date: Tue, 28 Mar 2006 18:43:05 +0200
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: [PATCH 00/18] RTC subsystem
Message-ID: <20060328184305.6fe7f1b5@inspiron>
In-Reply-To: <4487A3AA-AA9A-4B14-B8E1-7A63AEE711EC@kernel.crashing.org>
References: <20060318171946.821316000@towertech.it>
	<4487A3AA-AA9A-4B14-B8E1-7A63AEE711EC@kernel.crashing.org>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Mar 2006 10:25:59 -0600
Kumar Gala <galak@kernel.crashing.org> wrote:

> 
> Alessandro, is there any mechanism to determine if an RTC is enabled  
> through /dev or sysfs?
> 
> The DS1672 has an enable counting bit in its I2C register interface.   
> I can have a set time enable it if its not, however I'd like to  
> report to user space the fact that its not enabled.

 No mechanism, an rtc is actually supposed to be running. You may want
 to export a sysfs attribute from the ds1672 driver to inform
 user space.

 I can't check it right now, but iirc I enable the ds1672 counting
 bit in the driver init code.

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

