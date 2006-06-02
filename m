Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932508AbWFBR5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932508AbWFBR5v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 13:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932522AbWFBR5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 13:57:50 -0400
Received: from main.gmane.org ([80.91.229.2]:49597 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932508AbWFBR5u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 13:57:50 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Sitsofe Wheeler <sitsofe@yahoo.com>
Subject: Re: skge killing off snd_via686 interrupts on Fedora Core 5
Date: Fri, 02 Jun 2006 18:57:33 +0100
Message-ID: <pan.2006.06.02.17.57.32.607552@yahoo.com>
References: <pan.2006.05.27.14.43.20.450376@yahoo.com> <1149181417.12932.44.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cpc3-cwma2-0-0-cust739.swan.cable.ntl.com
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Jun 2006 18:03:37 +0100, Alan Cox wrote:

> On Sad, 2006-05-27 at 15:43 +0100, Sitsofe Wheler wrote:
>> We have a few machines which have been upgraded to to D-Link System Inc
>> DGE-530T Gigabit Ethernet adaptors. The unfortunate news is that shortly
>> after this was done people found that programs were either going
>> into the D state or hanging while trying to access the soundcard using
>> ALSA. Looking in the logs turned up this message:
>> 
>> irq 11: nobody cared (try booting with the "irqpoll" option)
> 
> If running with irqpoll fixes it then I'd suggest looking for BIOS
> updates. The older VIA boards often had buggy IRQ router information.

I have a feeling these machines are running the latest BIOS available to
them. I will look into this though.

> Are you updating from a 100Mbit card in the same slot or onboard
> ethernet ?

We are updating from the former (a removable PCI 100Mbit card being
replaced with a 1000Mbit one). If you think it's non BIOS related and
want to have a poke let me know and I'll add you to the sudoers list on
those machines.

-- 
Sitsofe | http://sucs.org/~sits/


