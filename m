Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932133AbWIZPv7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbWIZPv7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 11:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbWIZPv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 11:51:59 -0400
Received: from zod.pns.networktel.net ([209.159.47.6]:7365 "EHLO
	zod.pns.networktel.net") by vger.kernel.org with ESMTP
	id S932133AbWIZPv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 11:51:58 -0400
Message-ID: <45194A26.4060403@versaccounting.com>
Date: Tue, 26 Sep 2006 10:41:26 -0500
From: Ben Duncan <ben@versaccounting.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18 Nasty Lockup
References: <20060926123640.GA7826@tigers.local>
In-Reply-To: <20060926123640.GA7826@tigers.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

have gotten recently that as well. One time happen to have top running when
that happened again.

Top showed PDFLUSH consuming 100%CPU and 100% memeory

Do not know if this well help anyone, but thought I would share.

My lspci for the record:

00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different version?) (rev c1)
00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 1 (rev c1)
00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4 (rev c1)
00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3 (rev c1)
00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2 (rev c1)
00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5 (rev c1)
00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a3)
00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller (rev a3)
00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller (rev a3)
00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller (rev a3)
00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet Controller (rev a1)
00:06.0 Multimedia audio controller: nVidia Corporation nForce2 AC97 Audio Controler (MCP) 
(rev a1)
00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI Bridge (rev a3)
00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2)
00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1)
01:09.0 Mass storage controller: Silicon Image, Inc. SiI 3112 [SATALink/SATARaid] Serial ATA 
Controller (rev 02)
02:00.0 VGA compatible controller: nVidia Corporation NV18 [GeForce4 MX 440 AGP 8x] (rev a2)


Greg Schafer wrote:
> Hi
> 
> This is a _hard_ lockup. No oops, no magic sysrq, no nuthin, just a
> completely dead machine with only option the reset button. Usually happens
> within a couple of minutes of desktop use but is 100% reproducible. Problem
> is still there in a fresh checkout of current Linus git tree (post 2.6.18).
> 
<SNIP>
-- 
Ben Duncan   - Business Network Solutions, Inc. 336 Elton Road  Jackson MS, 39212
"Never attribute to malice, that which can be adequately explained by stupidity"
        - Hanlon's Razor

