Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262827AbTHUQ4E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 12:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262828AbTHUQ4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 12:56:04 -0400
Received: from natsmtp00.webmailer.de ([192.67.198.74]:13259 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S262827AbTHUQ4D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 12:56:03 -0400
Message-ID: <3F44F9D0.5010606@softhome.net>
Date: Thu, 21 Aug 2003 18:56:48 +0200
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Richard B. Johnson" <root@chaos.analogic.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pankaj Garg <PGarg@MEGISTO.com>, Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: Messaging between kernel modules and User Apps
References: <mYVo.39N.19@gated-at.bofh.it> <mZou.3Ff.29@gated-at.bofh.it> <n0ud.4F4.15@gated-at.bofh.it>
In-Reply-To: <n0ud.4F4.15@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
>>The de facto standard for network devices is to use sockets.
>>For character and and block devices Unix/Linux uses the
>>open/poll/ioctl/read mechanisms.
> 
> That sounds fine, but..
> 
>>You could send your module a pid via proc and have it send a
>>signal to your application as a result of an event.
> 
> ... please don't even entertain such sick ideas.

   Especially when there is fcntl(F_{G,S}ET{OWN,SIG}) infrastructure in 
place - kill_fasync().

