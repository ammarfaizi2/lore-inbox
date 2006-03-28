Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbWC1RwI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbWC1RwI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 12:52:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932094AbWC1RwH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 12:52:07 -0500
Received: from mx0.towertech.it ([213.215.222.73]:62153 "HELO mx0.towertech.it")
	by vger.kernel.org with SMTP id S932092AbWC1RwG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 12:52:06 -0500
Date: Tue, 28 Mar 2006 19:51:51 +0200
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: [PATCH 00/18] RTC subsystem
Message-ID: <20060328195151.3c36099b@inspiron>
In-Reply-To: <19E77D21-1080-48D4-A68C-923E0CD298B3@kernel.crashing.org>
References: <20060318171946.821316000@towertech.it>
	<4487A3AA-AA9A-4B14-B8E1-7A63AEE711EC@kernel.crashing.org>
	<20060328184305.6fe7f1b5@inspiron>
	<19E77D21-1080-48D4-A68C-923E0CD298B3@kernel.crashing.org>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Mar 2006 11:17:51 -0600
Kumar Gala <galak@kernel.crashing.org> wrote:

> >  No mechanism, an rtc is actually supposed to be running. You may want
> >  to export a sysfs attribute from the ds1672 driver to inform
> >  user space.
> 
> Any suggestions on what to call it?

 you can either use the name of the bit, according to the datasheet,
 or "enabled".

> >  I can't check it right now, but iirc I enable the ds1672 counting
> >  bit in the driver init code.
> 
> Hmm, I didn't see that.  I was going to send a patch to have  
> ds1672_set_mmss() always enable the counting bit.

 please do. I'd appreciate if you can also add a check 
 for this bit on driver init and a printk to warn
 the user if it is disabled.

 thanks!
 

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

