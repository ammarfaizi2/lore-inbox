Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278329AbRJMQXH>; Sat, 13 Oct 2001 12:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278325AbRJMQW6>; Sat, 13 Oct 2001 12:22:58 -0400
Received: from ns.suse.de ([213.95.15.193]:2319 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S278331AbRJMQWr>;
	Sat, 13 Oct 2001 12:22:47 -0400
Date: Sat, 13 Oct 2001 18:23:18 +0200 (CEST)
From: Dave Jones <davej@suse.de>
To: Rolf Fokkens <fokkensr@linux06.vertis.nl>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: cpus_allowed
In-Reply-To: <01101316594000.02369@home01>
Message-ID: <Pine.LNX.4.30.0110131822290.7753-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Oct 2001, Rolf Fokkens wrote:

> It resulted in some new curiosity: where's cpus_allowed initialized? I can
> only find an assignment to cpus_allowed for softirq's but no initialization
> for other processes. I assume the correct init value would be "0xffffffff" or
> -1. Can't find it though.

include/linux/sched.h:    cpus_allowed: -1,

regards,

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

