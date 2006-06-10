Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750740AbWFJBq1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbWFJBq1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 21:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbWFJBq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 21:46:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57478 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750740AbWFJBq1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 21:46:27 -0400
Date: Fri, 9 Jun 2006 18:45:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: dsaxena@plexity.net
Cc: alessandro.zummo@towertech.it, linux-kernel@vger.kernel.org,
       rmk@arm.linux.org.uk
Subject: Re: [PATCH] Add driver for ARM AMBA PL031 RTC
Message-Id: <20060609184552.2bf9696a.akpm@osdl.org>
In-Reply-To: <20060517000142.GA23236@plexity.net>
References: <20060516214813.GA28414@plexity.net>
	<20060517010259.5a035b20@inspiron>
	<20060517000142.GA23236@plexity.net>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2006 17:01:42 -0700
Deepak Saxena <dsaxena@plexity.net> wrote:

> +	return -ENOIOCNTLCMD;

Tell me you forgot to run `quilt refresh' too?

--- devel/drivers/rtc/rtc-pl031.c~add-driver-for-arm-amba-pl031-rtc-fix	2006-06-09 18:44:52.000000000 -0700
+++ devel-akpm/drivers/rtc/rtc-pl031.c	2006-06-09 18:45:07.000000000 -0700
@@ -81,7 +81,7 @@ static int pl031_ioctl(struct device *de
 		return 0;
 	}
 
-	return -ENOIOCNTLCMD;
+	return -ENOIOCTLCMD;
 }
 
 static int pl031_read_time(struct device *dev, struct rtc_time *tm)
_

