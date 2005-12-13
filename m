Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932619AbVLMXIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932619AbVLMXIz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 18:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932620AbVLMXIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 18:08:55 -0500
Received: from amdext4.amd.com ([163.181.251.6]:30353 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S932619AbVLMXIy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 18:08:54 -0500
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
Date: Tue, 13 Dec 2005 16:10:15 -0700
From: "Jordan Crouse" <jordan.crouse@amd.com>
To: gardner.ben@gmail.com
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386: GPIO driver for AMD CS5535/CS5536
Message-ID: <20051213231015.GB8896@cosmic.amd.com>
MIME-Version: 1.0
User-Agent: Mutt/1.5.11
X-WSS-ID: 6F818BFD1BK2017129-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> A simple driver for the CS5535 and CS5536 that allows a user-space
> program to manipulate GPIO pins.
> The CS5535/CS5536 chips are Geode processor companion devices.

> Signed-off-by: Ben Gardner <bgardner <at> wabtec.com>

This all looks excellent to me.  Just FYI - If you want to get rid of the
rdmsr and just use the PCI header, you can also get the IO base of the 
GPIO registers from BAR1 of the DIVIL device.   Not a big deal,
but some people like to stay away from MSR accesses if they can avoid it.

Thanks for your hard work - its good to see Geode users pop up in the
community! :)

Jordan
-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>

