Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbWC1QZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbWC1QZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 11:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932114AbWC1QZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 11:25:58 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:25120 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S932105AbWC1QZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 11:25:58 -0500
In-Reply-To: <20060318171946.821316000@towertech.it>
References: <20060318171946.821316000@towertech.it>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4487A3AA-AA9A-4B14-B8E1-7A63AEE711EC@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, akpm@zip.com.au
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 00/18] RTC subsystem
Date: Tue, 28 Mar 2006 10:25:59 -0600
To: Alessandro Zummo <a.zummo@towertech.it>
X-Mailer: Apple Mail (2.746.3)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mar 18, 2006, at 11:19 AM, Alessandro Zummo wrote:

>
>  RTC subsystem.
>
>  Original RFC available at http://lkml.org/lkml/2005/12/20/220
>
>  Changelog. Between parentheses is the name
>  of the person that suggested the change.
>
>  - license and tristate for rtc-lib.c (Andrian Bunk)
>  - added driver for ST M48T86
>
>  The following patches have been incorporated:
>
>   none
>
>  The following items are in the TODO:
>
>  - Documentation of exported functions
>  - Handling of max_user_freq
>  - 11 min ntp update mode

Alessandro, is there any mechanism to determine if an RTC is enabled  
through /dev or sysfs?

The DS1672 has an enable counting bit in its I2C register interface.   
I can have a set time enable it if its not, however I'd like to  
report to user space the fact that its not enabled.

thanks

- kuamr
