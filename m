Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262577AbTIUVtS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 17:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262580AbTIUVtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 17:49:18 -0400
Received: from mail.g-housing.de ([62.75.136.201]:9881 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S262577AbTIUVtQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 17:49:16 -0400
Message-ID: <3F6E1CDC.6080901@g-house.de>
Date: Sun, 21 Sep 2003 23:49:16 +0200
From: Christian <evil@g-house.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5b) Gecko/20030917
X-Accept-Language: de-de, de, en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: lockups with 2.4.2x
References: <3F6D134E.2080505@g-house.de> <20030921053816.GD589@alpha.home.local> <3F6DA70A.6030100@g-house.de>
In-Reply-To: <3F6DA70A.6030100@g-house.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian wrote:
> hm, yes, i could disable the ServeRaid module. gotta find out how to 
> disable the builtin IDE / Symbios other than recompile the kernel...
[...]

i took your advice and booted with "nosmp" and "noacpi" into
single-user. then i enabled all modules i used to load. i tried to
produce some I/O with "updatedb" and "find /" and so on, everything
looked fine.

the most time consuming part was starting some apps out of my
init-scripts, see if the survive some minutes while using the system.

i finally narrowed it down to a few applications left, but further
testing is required. (due to my lack of time, i'll go on tomorrow)

>> You may also have a defect in your RAM.

i did not try removing RAM or booting a 2.4.22 with no "HIGHMEM set".

oh, an can it be, that when i boot with "nosmp noapic", the use of APIC
is forced and APIC is initialized upon booting? i don't have the exact
dmesg output right now, but i remembered sth. like this.

Thank you,
Christian.
-- 
BOFH excuse #417:

Computer room being moved.  Our systems are down for the weekend.






