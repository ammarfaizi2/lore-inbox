Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933786AbWKSXxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933786AbWKSXxd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 18:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933789AbWKSXxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 18:53:33 -0500
Received: from mx0.towertech.it ([213.215.222.73]:59305 "HELO mx0.towertech.it")
	by vger.kernel.org with SMTP id S933786AbWKSXxc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 18:53:32 -0500
Date: Mon, 20 Nov 2006 00:50:03 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: David Brownell <david-b@pacbell.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 2.6.19-rc6] rtc framework handles periodic irqs
Message-ID: <20061120005003.2c55e005@inspiron>
In-Reply-To: <200611162312.09415.david-b@pacbell.net>
References: <200611162312.09415.david-b@pacbell.net>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2006 23:12:09 -0800
David Brownell <david-b@pacbell.net> wrote:

> The RTC framework has an irq_set_freq() method that should be used to
> manage the periodic IRQ frequency, but the current ioctl logic doesn't
> know how to do that.  This patch teaches it how.
> 
> This means that drivers implementing irq_set_freq() will automatically
> support RTC_IRQP_{READ,SET} ioctls; that logic doesn't need duplication
> within the driver.
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

 Acked-by: Alessandro Zummo <a.zummo@towertech.it>

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

