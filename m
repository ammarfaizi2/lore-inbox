Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751265AbVLIEZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbVLIEZa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 23:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbVLIEZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 23:25:29 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:63805 "EHLO
	pd4mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751265AbVLIEZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 23:25:29 -0500
Date: Thu, 08 Dec 2005 22:24:58 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Problem with using spinlocks when kernel is compiled without
 smp-support
In-reply-to: <5hwF1-kN-17@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <4399071A.10308@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <5hwF1-kN-17@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dirk Henning Gerdes wrote:
> Hello Andrew!
> 
> I have the following problem on 2.6.15-rc5-mm1
> 
> When compiling a module using spinlocks I get the following
> error-message, when SMP is disabled in my Kernel-config:

..

> shouldn't it be possible to use spinlocks in my code even if I don't
> support SMP for compatiblity ?

Yes, it is, something must be set up wrong in your compilation. In 
particular, are you trying to use old 2.4-style makefiles to build 
instead of one that calls the kernel's build system? If so, don't, it 
doesn't work..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

