Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932316AbWCRI6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbWCRI6Z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 03:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbWCRI6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 03:58:25 -0500
Received: from mail.dvmed.net ([216.237.124.58]:30338 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932323AbWCRI6Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 03:58:24 -0500
Message-ID: <441BCBAE.2020302@garzik.org>
Date: Sat, 18 Mar 2006 03:58:22 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alejandro Bonilla <abonilla@linuxwireless.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Dual Core on Linux questions
References: <20060318082434.M33432@linuxwireless.org>
In-Reply-To: <20060318082434.M33432@linuxwireless.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alejandro Bonilla wrote:
> Hi,
> 
> I have a few questions about the PM Dual Core and how could it really work
> with Linux. Sorry if there are new patches on LKML about any of these things:
> 
> Could each processor or die, have it's own cpufreq scaling governor?

Sure.  On a laptop, if you don't need dual core power, it makes sense to 
turn off the unused core, even.

	Jeff


