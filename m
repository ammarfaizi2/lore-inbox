Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269815AbTGKIMu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 04:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269814AbTGKIMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 04:12:50 -0400
Received: from c180224.adsl.hansenet.de ([213.39.180.224]:32690 "EHLO
	sfhq.hn.org") by vger.kernel.org with ESMTP id S266639AbTGKIMo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 04:12:44 -0400
Message-ID: <3F0E74EB.9050704@portrix.net>
Date: Fri, 11 Jul 2003 10:27:23 +0200
From: Jan Dittmer <j.dittmer@portrix.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030524 Debian/1.3.1-1.he-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Kissner, Sven" <sven.kissner@tally.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: linux 2.5.75 & I2C_PROC
References: <97F6E34E67F1BA4B93F8C35F84D146620993B5@TGE-MAIL.tally.de>
In-Reply-To: <97F6E34E67F1BA4B93F8C35F84D146620993B5@TGE-MAIL.tally.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kissner, Sven wrote:
> Hi,
> 
> i'm using linux 2.5.75 on my debian box and want to run lm_sensors. The
> userspace apps (sensors-detect & sensors) require the module I2C_PROC,
> which I can't find within the kernel configuration. Are there any
> dependencies so I2C_PROC becomes available? I'm thankful for any
> enlightment. 

The proc interface to i2c didn't make it in 2.5 in favor for sysfs.
Just do a `find /sys | grep i2c` and you can cat & echo the various 
files to read/change the values.

Jan


-- 
Linux rubicon 2.5.74-mm3-jd2 #1 SMP Wed Jul 9 09:38:20 CEST 2003 i686

