Return-Path: <linux-kernel-owner+w=401wt.eu-S1754115AbWLRPCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754115AbWLRPCa (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 10:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754117AbWLRPCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 10:02:30 -0500
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:56336 "EHLO
	hp3.statik.tu-cottbus.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754115AbWLRPC3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 10:02:29 -0500
Message-ID: <4586AD83.5030600@s5r6.in-berlin.de>
Date: Mon, 18 Dec 2006 16:02:27 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.8) Gecko/20061030 SeaMonkey/1.0.6
MIME-Version: 1.0
To: "Robert P. J. Day" <rpjday@mindspring.com>
CC: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] Make entries in the "Device drivers" menu individually
 selectable
References: <Pine.LNX.4.64.0612140325340.13847@localhost.localdomain> <4583D008.40806@s5r6.in-berlin.de> <Pine.LNX.4.64.0612180444230.16929@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.64.0612180444230.16929@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert P. J. Day wrote:
> On Sat, 16 Dec 2006, Stefan Richter wrote:
>> Works for me, but I don't see a lot of benefit from it. Actually I see
>> two disadvantages of the patch:
> 
> ... snip ...
> 
>>  - There are two out-of-tree FireWire drivers for special purposes
                    ^^^^^^^^^^^
>> (one bus sniffer, one remote debugging aid) which might perhaps be
>> candidates for integration into mainline. These drivers do not use
>> the ieee1394 base driver.
[...]
> i've noticed this sort of thing before -- submenus containing entries
> that don't actually depend on the top-level config variable.  but
> which drivers are you talking about here?

As yet non-existent drivers. (Out-of-tree drivers.)

> i'm looking at the
> ieee1394/Kconfig file and every entry in that submenu appears to
> depend explicitly on IEEE1394.

Correct. What I described is purely hypothetical in case of
drivers/ieee1394. There surely are other submenus with actual
independent entries. But AFAIU you didn't touch such menus of course.

[...]
> in any event, as i mentioned earlier, i'm just trying to find a way to
> make the menu entries more obvious and more easily selectable, without
> having to enter each submenu to see what it represents.
[...]

Yes, this and the points you made in the other post are definitely valid.
-- 
Stefan Richter
-=====-=-==- ==-- =--=-
http://arcgraph.de/sr/
