Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932526AbWFHG2k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932526AbWFHG2k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 02:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932527AbWFHG2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 02:28:40 -0400
Received: from mail.sanpeople.com ([196.41.13.122]:57608 "EHLO
	za-gw.sanpeople.com") by vger.kernel.org with ESMTP id S932526AbWFHG2k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 02:28:40 -0400
Subject: Re: [PATCH] RTC: Ensure that time being passed to set_alarm() is
	valid.
From: Andrew Victor <andrew@sanpeople.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, alessandro.zummo@towertech.it, akpm@osdl.org
In-Reply-To: <20060607193121.GG13165@flint.arm.linux.org.uk>
References: <1149704455.20386.90.camel@fuzzie.sanpeople.com>
	 <20060607193121.GG13165@flint.arm.linux.org.uk>
Content-Type: text/plain
Organization: SAN People (Pty) Ltd
Message-Id: <1149747793.2114.4.camel@fuzzie.sanpeople.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 08 Jun 2006 08:23:13 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi, 

> > RTC: Ensure that the time being passed to set_alarm() is valid.
> 
> NAK.  rtc_valid_tm checks that the time/date is valid (eg, month is
> within range).  Alarms can have a "don't care" state for each part -
> for example, setting month to 0xff means "alarm every month".

OK. Drop this patch.


Regards,
  Andrew Victor


