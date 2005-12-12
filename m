Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750918AbVLLCI0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbVLLCI0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 21:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751028AbVLLCI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 21:08:26 -0500
Received: from smtp107.sbc.mail.re2.yahoo.com ([68.142.229.98]:34200 "HELO
	smtp107.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750903AbVLLCIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 21:08:25 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] Minor change to platform_device_register_simple prototype
Date: Sun, 11 Dec 2005 21:08:14 -0500
User-Agent: KMail/1.8.3
Cc: Greg KH <greg@kroah.com>, Russell King <rmk+lkml@arm.linux.org.uk>,
       LKML <linux-kernel@vger.kernel.org>,
       Alessandro Zummo <alessandro.zummo@towertech.it>
References: <20051205212337.74103b96.khali@linux-fr.org> <20051208215257.78d7c67a.khali@linux-fr.org> <20051211204458.22c60123.khali@linux-fr.org>
In-Reply-To: <20051211204458.22c60123.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512112108.16125.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 11 December 2005 14:44, Jean Delvare wrote:
> If the goal is to always use .probe and .remove, then
> platform_device_del() might become unneeded again in the long run.
> 

Only if you register just one platform device... As soon as you need to
do something else you'd need platfoprm_device_del() again.

-- 
Dmitry
