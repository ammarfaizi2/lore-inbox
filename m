Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263424AbTLDTPm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 14:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263466AbTLDTPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 14:15:42 -0500
Received: from stinkfoot.org ([65.75.25.34]:23937 "EHLO stinkfoot.org")
	by vger.kernel.org with ESMTP id S263424AbTLDTPl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 14:15:41 -0500
Message-ID: <3FCF87C4.2010301@stinkfoot.org>
Date: Thu, 04 Dec 2003 14:15:16 -0500
From: Ethan Weinstein <lists@stinkfoot.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: w83627hf watchdog
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My Supermicro X5DPL-iGM-O has a winbond w83627hf chip onboard that 
includes a watchdog timer.  I found a driver on freshmeat that points 
here: http://www.freestone.net/soft/pkg/w83627hf-wdt.tar.gz
but this does not seem to work correctly on 2.4.23, even with my 
modifications to the ioports and registers that Supermicro sent me. I 
have tried to contact the developer, he hasn't responded.  I also 
located a post to linux-kerel quite sometime ago:

http://seclists.org/lists/linux-kernel/2002/Dec/att-4150/w83627hf_wdt.c

  I haven't tried this driver just yet. The lm_sensors project seems to 
include a driver for this chip as well, but not for the watchdog part. 
The specifications Supermicro sent me for the watchdog function are 
located here:

http://www.stinkfoot.org/wdt.txt

Any help would greatly be appreciated, I know this particular chip is 
included with many motherboards.

Ethan


