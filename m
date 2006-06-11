Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbWFKSI2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWFKSI2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 14:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbWFKSI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 14:08:28 -0400
Received: from main.gmane.org ([80.91.229.2]:5092 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750705AbWFKSI1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 14:08:27 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Sitsofe Wheeler <sitsofe@yahoo.com>
Subject: Re: [SOLVED] skge killing off snd_via686 interrupts on Fedora Core 5
Date: Sun, 11 Jun 2006 19:08:20 +0100
Message-ID: <pan.2006.06.11.18.08.19.551743@yahoo.com>
References: <pan.2006.05.27.14.43.20.450376@yahoo.com> <1149181417.12932.44.camel@localhost> <pan.2006.06.04.09.45.33.201398@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cpc3-cwma2-0-0-cust739.swan.cable.ntl.com
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 04 Jun 2006 10:45:46 +0100, Sitsofe Wheeler wrote:

> (This accidentally fell off list so I'm going to see if I bodge it back)
> 
> On Sat, 03 Jun 2006 10:55:48 +0100, Alan Cox wrote:
>> Ar Sad, 2006-06-03 am 21:31 +0100, ysgrifennodd Sitsofe Wheeler:
>> > As mentioned in another reply the cards aren't onbord and are a PCI
>> > card upgrade.
>> 
>> Same slot as the card you upgraded from ?

Alan correctly surmised this was due to a VIA motherboard bug and moving
the gigabit card to a different slot solved the problem without the need
for noapic or irqpoll. The issue turned up with other network cards (e.g.
a tuplip and an 8139) so it was fairly clear the issue wasn't driver
related.

Just for the record the motherboard in question is a Gigabyte GA-7DX+,
host bridge is a AMD-760 [IGD4-1P], ISA bridge is a VIA VT82C686 [Apollo
Super South] (rev 40)). At least two of the slots in the machine are
"cursed".

-- 
Sitsofe | http://sucs.org/~sits/


