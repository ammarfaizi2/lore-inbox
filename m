Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271848AbRIQQmx>; Mon, 17 Sep 2001 12:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271847AbRIQQmd>; Mon, 17 Sep 2001 12:42:33 -0400
Received: from dynamic-135.remotepoint.com ([204.221.114.135]:61445 "EHLO
	AeroSpace.davidapt.local") by vger.kernel.org with ESMTP
	id <S271832AbRIQQmW>; Mon, 17 Sep 2001 12:42:22 -0400
Date: Mon, 17 Sep 2001 11:43:15 -0500
From: David Fries <dfries@mail.win.org>
To: linux-kernel@vger.kernel.org
Subject: how to get cpu_khz?
Message-ID: <20010917114315.A4041@aerospace.fries.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using the TSC of the Pentium processors to get some precise timing
delays for writing to a eeprom (bit banging bus operations), and it
works just fine, but the cpu_khz variable isn't exported to a kernel
module, so I hardcoded in my module.  It works fine for that one
system, but obviously I don't want to hard code it for the general
case.  I guess I could write my own routine to figure out what the
cpu_khz is, but it is already done, so how do I get access to it?

-- 
		+---------------------------------+
		|      David Fries                |
		|      dfries@mail.win.org        |
		+---------------------------------+
