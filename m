Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261564AbVEPNoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbVEPNoO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 09:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbVEPNoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 09:44:13 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:9741 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S261564AbVEPNoI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 09:44:08 -0400
Message-ID: <4288A3A5.5010006@rtr.ca>
Date: Mon, 16 May 2005 09:44:05 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050420 Debian/1.7.7-2
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Disk write cache (Was: Hyper-Threading Vulnerability)
References: <1115963481.1723.3.camel@alderaan.trey.hu> <200505152156.18194.gene.heskett@verizon.net> <42880620.8000300@rtr.ca> <200505152308.04960.gene.heskett@verizon.net>
In-Reply-To: <200505152308.04960.gene.heskett@verizon.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:
>
>>There's your clue.  The drive LEDs normally reflect activity
>>over the ATA bus (the cable!). If they're not on, then the drive
>>isn't receiving data/commands from the host.
>
> That was my theory too Mark, but Jeff G. says its not a valid 
> indicator.  So who's right?

If the LEDs are connected to the controller on the motherboard,
then they are a strict indication of activity over the cable
between the drive and controller (if they function at all).
But it is possible for software to leave those LEDs permanently
in the "on" state, depending on the register sequence used.

If the LEDs are on the drive itself, they may indicate transfers
over the connector (cable) -- usually always the case -- or they
could indicate transfers to/from the media.

Cheers

