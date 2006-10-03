Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932509AbWJCJkq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932509AbWJCJkq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 05:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932545AbWJCJkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 05:40:46 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:53901 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932509AbWJCJkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 05:40:46 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <45222F2D.9020808@s5r6.in-berlin.de>
Date: Tue, 03 Oct 2006 11:36:45 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Andrew Morton <akpm@osdl.org>, Judith Lebzelter <judith@osdl.org>,
       linuxppc-dev@ozlabs.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] mark virt_to_bus/bus_to_virt as __deprecated on	i386
References: <20061002214954.GD665@shell0.pdx.osdl.net>	 <20061002234428.GE3278@stusta.de> <20061003012241.GF3278@stusta.de>	 <1159850245.5482.32.camel@localhost.localdomain>	 <20061002214400.0a83b743.akpm@osdl.org> <1159850979.5482.40.camel@localhost.localdomain>
In-Reply-To: <1159850979.5482.40.camel@localhost.localdomain>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
> On Mon, 2006-10-02 at 21:44 -0700, Andrew Morton wrote:
>> Net result: lots of new warnings, no fixed bugs.
> 
> Are you sure the warnings won't cause somebody like Al to go through
> them all and fix them ?

If you mean by "fix" to actually convert to generic DMA mapping, then
this task may turn out to require in-depth knowledge of the driver and
its field of application in some or many of these cases.
-- 
Stefan Richter
-=====-=-==- =-=- ---==
http://arcgraph.de/sr/
