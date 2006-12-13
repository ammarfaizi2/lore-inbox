Return-Path: <linux-kernel-owner+w=401wt.eu-S964853AbWLMAtA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964853AbWLMAtA (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 19:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbWLMAtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 19:49:00 -0500
Received: from mx0.towertech.it ([213.215.222.73]:34404 "HELO mx0.towertech.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964853AbWLMAs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 19:48:59 -0500
Date: Wed, 13 Dec 2006 01:42:11 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: David Brownell <david-b@pacbell.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: [patch 2.6.19-git] rtc framework:  rtc_wkalrm.enabled reporting
 updates
Message-ID: <20061213014211.23bff424@inspiron>
In-Reply-To: <200612121149.13913.david-b@pacbell.net>
References: <200612121149.13913.david-b@pacbell.net>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2006 11:49:13 -0800
David Brownell <david-b@pacbell.net> wrote:

> Fix a glitch in the procfs dumping of whether the alarm IRQ is enabled:
> use the traditional name (from drivers/char/rtc.c and many other places)
> of "alarm_IRQ", not "alrm_wakeup" (which didn't even match the efirtc
> code, which originated that reporting API).
> 
> Also, update a few of the RTC drivers to stop providing that duplicate
> status, and/or to expose it properly when reporting the alarm state.
> We really don't want every RTC driver doing their own thing here...
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

 Acked-by: Alessandro Zummo <a.zummo@towertech.it>

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

