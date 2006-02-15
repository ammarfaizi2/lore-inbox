Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422909AbWBOB0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422909AbWBOB0U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 20:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422910AbWBOB0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 20:26:20 -0500
Received: from mx0.towertech.it ([213.215.222.73]:60819 "HELO mx0.towertech.it")
	by vger.kernel.org with SMTP id S1422909AbWBOB0T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 20:26:19 -0500
Date: Wed, 15 Feb 2006 01:24:33 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/11] RTC subsystem, class
Message-ID: <20060215012433.79e4dc45@inspiron>
In-Reply-To: <200602132249.13055.dtor_core@ameritech.net>
References: <20060213225416.865078000@towertech.it>
	<20060213225417.074551000@towertech.it>
	<200602132249.13055.dtor_core@ameritech.net>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Feb 2006 22:49:12 -0500
Dmitry Torokhov <dtor_core@ameritech.net> wrote:

> On Monday 13 February 2006 17:54, Alessandro Zummo wrote:
> > +
> > +struct rtc_device
> > +{
> > +	int id;
> > +	struct module *owner;
> > +	struct class_device class_dev;
> > +	struct semaphore ops_lock;
> 
> Alessandro,
> 
> I believe we are moving from struct semaphore to mutex whenever possible.
> It would be nice if new code used new primitives.

 will convert, thanks.
-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

