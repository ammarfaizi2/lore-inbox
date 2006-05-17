Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751081AbWEQV1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbWEQV1r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 17:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbWEQV1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 17:27:47 -0400
Received: from mx0.towertech.it ([213.215.222.73]:45524 "HELO mx0.towertech.it")
	by vger.kernel.org with SMTP id S1751081AbWEQV1r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 17:27:47 -0400
Date: Wed, 17 May 2006 23:27:42 +0200
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc subsystem, use ENOIOCTLCMD where appropriate
Message-ID: <20060517232742.2ac4ccaa@inspiron>
In-Reply-To: <20060517142510.b3fcfb7d.rdunlap@xenotime.net>
References: <20060517013033.10d08a8f@inspiron>
	<20060517142510.b3fcfb7d.rdunlap@xenotime.net>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2006 14:25:10 -0700
"Randy.Dunlap" <rdunlap@xenotime.net> wrote:

> On Wed, 17 May 2006 01:30:33 +0200 Alessandro Zummo wrote:
> 
> > 
> > 
> > Appropriately use -ENOIOCTLCMD when
> > the ioctl is not implemented by a driver.
> 
> so this return value does not go back to userspace?
> Comment in linux/errno.h says:
> /* Should never be seen by user programs */
> 
> and ENOTTY is the return value for "Inappropriate ioctl for device":
>

 you're right. I'll go for ENOTTY. thanks.


-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

