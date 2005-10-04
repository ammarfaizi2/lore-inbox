Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751174AbVJDDtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbVJDDtK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 23:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbVJDDtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 23:49:10 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:8062 "EHLO
	pd4mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751174AbVJDDtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 23:49:09 -0400
Date: Mon, 03 Oct 2005 21:48:56 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: make xconfig fails for older kernels
In-reply-to: <4TJDn-2mm-3@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <4341FBA8.3020208@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8; format=flowed
Content-transfer-encoding: 8BIT
X-Accept-Language: en-us, en
References: <4TJDn-2mm-3@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felix Oxley wrote:
> I have downloaded 2.6.0 + patches up to 2.6.13 from kernel.org.
> 
> When I try to configure the kernel using 'make xconfig' I get the following 
> error:
> 
> scripts/kconfig/mconf.c:91: error: static declaration of ‘current_menu’ 
> follows non-static declaration
> scripts/kconfig/lkc.h:63: error: previous declaration of ‘current_menu’ was 
> here
> make[1]: *** [scripts/kconfig/mconf.o] Error 1
> make: *** [xconfig] Error 2
> 
> I attempted make menuconfig, make config, and make oldconfig but each failed 
> with the same error,
> 
> This happens on 2.6.0, 2.6.1, 2.6.2 2.6.3, 2.6.4.
> I have previously built newer kernels such as 2.6.13-rc2-rt7 without a 
> problem.

What gcc version? The configuration program may have had some compile 
bugs with newer compilers that were fixed in later kernels. In 
particular I think gcc4 is stricter about those "static declaration 
follows non-static" problems.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

