Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270370AbTHSMmO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 08:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270391AbTHSMmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 08:42:14 -0400
Received: from gw-nl5.philips.com ([212.153.235.109]:57077 "EHLO
	gw-nl5.philips.com") by vger.kernel.org with ESMTP id S270370AbTHSMmM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 08:42:12 -0400
Message-ID: <3F421B6C.2050300@basmevissen.nl>
Date: Tue, 19 Aug 2003 14:43:24 +0200
From: Bas Mevissen <ml@basmevissen.nl>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Anders Karlsson <anders@trudheim.com>
Cc: Christian Axelsson <smiler@lanil.mine.nu>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Current status of Intel PRO/Wireless 2100
References: <3F3CA3A0.5030905@lanil.mine.nu> <1060942697.2296.83.camel@tor.trudheim.com>
In-Reply-To: <1060942697.2296.83.camel@tor.trudheim.com>
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anders Karlsson wrote:

> On Fri, 2003-08-15 at 10:10, Christian Axelsson wrote:
> 

  (mini-PCI WLAN cards in notebooks)

> For the time being those mini-PCI cards is dead weight in the laptop I
> am afraid. I hope that either Intel suddenly sees sense (snowflake in
> hell analogy coming on) or some bright spark reverse engineers the card
> and writes an alpha driver that surpasses the functionality of the Intel
> beta drivers they keep under lock and key internally.
> 
> I'll probably locate some Prism CardBus card in the meantime to use.
> 

My dead weight was called Dell TrueMobile 1300 (with BroadCom chipset). 
What I did is buying a NetGear WG311 PCI card (802.11b/g). It contains a 
mini-pci card in a slot unders a metal cover and some small stuff on the 
PCI-shape PCB.

The cover is easy to remove (only 3 pins) and the antenna is not 
soldered, but connected with the same connector as in my notebook. I 
could only connect 1 (main) antenna, but the PCI card has only one 
antenna too. So you only loose antenna diversity.

The NetGear contains an Atheros chipset. There is some open source stuff 
available (URL forgotten) and a driver (mafwifi) with a binary-only 
hardware abstraction. Not really what you want, but at least a start. A 
combination of both may lead to a more desirable result. But for me it 
is fine to use. Only I can not issue bug reports when the driver has 
been loaded since the last boot.

Oh,
#include <stddisclaimer.h>
#include <donttryat.h>
#include <nowarrenty.h>

Regards,

Bas.

BTW. I have a PCI card with Broadcom chipset for sale now :-)



