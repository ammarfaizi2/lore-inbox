Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261343AbVELAAo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261343AbVELAAo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 20:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbVELAAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 20:00:40 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:40269 "EHLO
	pd4mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S261343AbVELAAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 20:00:03 -0400
Date: Wed, 11 May 2005 17:59:40 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Disable cached memory
In-reply-to: <42ze5-6rp-13@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <42829C6C.9010003@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <42ze5-6rp-13@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chen Bill-R63518 wrote:
> Hi,
> When I cat "/proc/meminfo", I found there were too many memory cached which may result in kernel oom and killing something. I want to disable the cacheable feature, or limit the maximum of memory sizes which could be used for cached data. But anyone know how I shall do in the kernel? I use 2.4.20 kernel. Thanks.

It doesn't work that way. If memory is needed for something else, the 
amount of memory used for cache will be reduced.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

