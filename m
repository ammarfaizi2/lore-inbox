Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266336AbUAGUAJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 15:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266339AbUAGUAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 15:00:09 -0500
Received: from 217-124-44-236.dialup.nuria.telefonica-data.net ([217.124.44.236]:46214
	"EHLO dardhal.mired.net") by vger.kernel.org with ESMTP
	id S266336AbUAGUAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 15:00:01 -0500
Date: Wed, 7 Jan 2004 20:59:57 +0100
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
To: Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: sensors, again
Message-ID: <20040107195956.GA5143@localhost>
Mail-Followup-To: Kernel development list <linux-kernel@vger.kernel.org>
References: <200401071316.33984.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401071316.33984.gene.heskett@verizon.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 07 January 2004, at 13:16:33 -0500,
Gene Heskett wrote:

> Is there a utility that can scan the kernel and tell me what has 
> actually been builtin?
> 
Just a "zcat /proc/config.gz" if you compiled the kernel with support
for it ("Enable access to .config through /proc/config.gz").

> I ask because there is no trace of the ic2_algobit in /sys, its one of 
> the errors sensors reports, and it is (supposedly, thats why I ask 
> this question) compiled in.  No errors were noted during any of the 
> about 20 or more kernel compiles I've done trying everyones ideas 
> out.
> 
The name of the driver is now "i2c-algo-bit.ko", not "ic2_algobit" :-)
You can find this driver under "I2C Algorithms" with the name of 
"I2C bit-banging interfaces".

> Also, from a thread earlier today, I assume 2.6.1-rc2 is out, but 
> ANAICT no announcement was made here on this list.  Did I miss it, 
> and if so can it be reposted?  Everything that falls out of a kmail 
> search has  RE: in front of it.
> 
It is out, but no official announcement has been done.

Greetings.

-- 
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.6.1-rc2)
