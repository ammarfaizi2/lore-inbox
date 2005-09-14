Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932520AbVINSlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932520AbVINSlI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 14:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932523AbVINSlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 14:41:07 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:27633 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S932520AbVINSlF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 14:41:05 -0400
Message-ID: <43286E4B.1070809@mvista.com>
Date: Wed, 14 Sep 2005 11:39:07 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: lkml <linux-kernel@vger.kernel.org>, yoshfuji@linux-ipv6.org,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>, joe-lkml@rameria.de
Subject: NTP leap second question
References: <1126720091.3455.56.camel@cog.beaverton.ibm.com> <1126720398.3455.58.camel@cog.beaverton.ibm.com>
In-Reply-To: <1126720398.3455.58.camel@cog.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It appears that a leap second is scheduled.  One of our customers is 
concerened about his application around this.  Could one of you NTP 
wizards help me to understand NTP a bit better.

First, I wonder if we suppressed the leap second insert and time then 
became out of sync by a second, would NTP "creap" the time back in sync 
or would the one second out of sync cause it to quit?

Assuming NTP would do the "creap" thing, is there a way to tell NTP not 
to insert the leap second?
-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
