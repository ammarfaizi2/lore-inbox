Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263522AbTLEFFh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 00:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263853AbTLEFFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 00:05:36 -0500
Received: from stinkfoot.org ([65.75.25.34]:27264 "EHLO stinkfoot.org")
	by vger.kernel.org with ESMTP id S263522AbTLEFFc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 00:05:32 -0500
Message-ID: <3FD012C4.3060206@stinkfoot.org>
Date: Fri, 05 Dec 2003 00:08:20 -0500
From: Ethan Weinstein <lists@stinkfoot.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6a) Gecko/20031103
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: w83627hf watchdog
References: <3FCF87C4.2010301@stinkfoot.org>
In-Reply-To: <3FCF87C4.2010301@stinkfoot.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ethan Weinstein wrote:

> My Supermicro X5DPL-iGM-O has a winbond w83627hf chip onboard that 
> includes a watchdog timer.  I found a driver on freshmeat that points 
> here: http://www.freestone.net/soft/pkg/w83627hf-wdt.tar.gz
> but this does not seem to work correctly on 2.4.23, even with my 
> modifications to the ioports and registers that Supermicro sent me. I 
> have tried to contact the developer, he hasn't responded.  I also 
> located a post to linux-kerel quite sometime ago:
> 
> http://seclists.org/lists/linux-kernel/2002/Dec/att-4150/w83627hf_wdt.c

Thought I'd mention that the above mentioned driver apparently works
quite well with the w83627hf, I've run some preliminary tests simulating
lockups, and the box reboots according to the timer setttings.

Ethan

