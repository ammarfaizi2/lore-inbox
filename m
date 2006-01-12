Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161258AbWALUwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161258AbWALUwZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 15:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161260AbWALUwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 15:52:25 -0500
Received: from mail.dvmed.net ([216.237.124.58]:30947 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1161258AbWALUwY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 15:52:24 -0500
Message-ID: <43C6C16C.8010506@pobox.com>
Date: Thu, 12 Jan 2006 15:51:56 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Reuben Farrelly <reuben-lkml@reub.net>, htejun@gmail.com, ric@emc.com,
       axboe@suse.de, neilb@suse.de, mingo@elte.hu,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-mm2
References: <43C55B31.5000201@reub.net>	<20060111194517.GE5373@suse.de>	<20060111195349.GF5373@suse.de>	<43C5D1CA.7000400@reub.net>	<20060112080051.GA22783@htj.dyndns.org>	<43C61598.7050004@reub.net>	<20060112111846.GA19976@htj.dyndns.org>	<43C645ED.40905@reub.net>	<43C64C3B.5070704@emc.com>	<43C64DF6.7060604@reub.net>	<20060112135533.GA29675@htj.dyndns.org>	<43C6AD72.2010101@reub.net> <20060112123253.26ec3e5f.akpm@osdl.org>
In-Reply-To: <20060112123253.26ec3e5f.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Andrew Morton wrote: > Reuben Farrelly
	<reuben-lkml@reub.net> wrote: > >> Indeed that seems to fix it. I've
	just booted -mm3 and it came up with no >> problems at all. > > > whew.
	> > What about all the other problems? The oops under ata_device_add()?
	> > And is it still saying this? [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Reuben Farrelly <reuben-lkml@reub.net> wrote:
> 
>> Indeed that seems to fix it.  I've just booted -mm3 and it came up with no 
>> problems at all.
> 
> 
> whew.
> 
> What about all the other problems?  The oops under ata_device_add()?
> 
> And is it still saying this?

ACK the questions...  I confess I dove into this earlier today, and 
quickly got lost in the multiple bug reports :(  Nothing against Reuben 
-- we need more motivated bug reporters like him!

	Jeff



