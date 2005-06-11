Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261725AbVFKQ0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261725AbVFKQ0Z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 12:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261726AbVFKQ0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 12:26:25 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:56036 "EHLO
	pd4mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S261725AbVFKQ0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 12:26:09 -0400
Date: Sat, 11 Jun 2005 10:25:31 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: 'hello world' module
In-reply-to: <4egz4-2tj-15@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <42AB107B.3030203@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=UTF-8
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <4egz4-2tj-15@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Warne wrote:
> 2.4.31, GCC 3.4.4
> 
> Build like:
> 
> gcc -D__KERNEL__ -I/usr/src/linux/include -DMODULE -Wall -O2 -c hello.c -o 
> hello.o

That compilation method will not work on 2.6. You have to use the kernel 
makefiles to build the module. See:

http://linuxdevices.com/articles/AT4389927951.html

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

