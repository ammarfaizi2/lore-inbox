Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932385AbWJOJWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385AbWJOJWP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 05:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbWJOJWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 05:22:15 -0400
Received: from gepetto.dc.ltu.se ([130.240.42.40]:56230 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S932385AbWJOJWO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 05:22:14 -0400
Message-ID: <4531FE6D.3050905@student.ltu.se>
Date: Sun, 15 Oct 2006 11:25:01 +0200
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] Char: stallion, use pr_debug macro
References: <347066701121713986@wsc.cz> <4531E294.7050205@student.ltu.se> <4531EF3A.70101@gmail.com>
In-Reply-To: <4531EF3A.70101@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby wrote:
> Richard Knutsson wrote:
>> Sorry for the late respond, just saw it...
>>
>> Jiri Slaby wrote:
>>> stallion, use pr_debug macro
>>>   
>> As it is a driver, is it not recommended to use the "dev_dbg()" found 
>> in include/linux/device.h, instead of pr_debug?
>
> Only iff you have access to struct device. And you don't have here, 
> but 2 prints in stl_initpcibrd. This would be fixed in next patch 
> serie...
Oh, missed that. Thanks for clearing that up.

Sorry about the noise
Richard Knutsson

