Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265713AbUBRToA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 14:44:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267976AbUBRTnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 14:43:37 -0500
Received: from mailwasher.lanl.gov ([192.16.0.25]:29366 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S267622AbUBRTmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 14:42:39 -0500
Subject: Re: AIC7xxx kernel problem with 2.4.2[234] kernels
From: Stephen Smoogen <smoogen@lanl.gov>
To: linux-kernel@vger.kernel.org
Cc: "Justin T. Gibbs" <gibbs@scsiguy.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
In-Reply-To: <1074715181.21214.30.camel@smoogen1.lanl.gov>
References: <1074289406.5752.5.camel@smoogen2.lanl.gov>
	 <2582475408.1074292759@aslan.btc.adaptec.com>
	 <1074293952.1321.5.camel@smoogen2.lanl.gov>
	 <1074715181.21214.30.camel@smoogen1.lanl.gov>
Content-Type: text/plain
Organization: CCN-2 ESM/SSC
Message-Id: <1077133347.3797.10.camel@smoogen2.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 18 Feb 2004 12:42:27 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just so that people googling on this in later months days, years..
versus email me directly.. it seems to be a hardware difference with the
U2 LVD Carrier that is causing the problem with the timeouts. I am
trying to get a disk, carrier, and plug to Justin so that he can run a
SCSI analyzer on it to find out what this is 'mangling'. 

This is probably a bad workaround for anyone else seeing this but a way
to get the system to boot was turn off DV in the module for the
controller:  dv:{0,0,0,0} allowed for the system to boot and work pretty
well with a bonnie test. Justin and others would know if it were good.

On Wed, 2004-01-21 at 12:59, Stephen Smoogen wrote:
> Hopefully this wont spark more contention, but here is the additional
> info I have dug up:
> 
> The cabling goes from the onboard scsi card to a removable carrier tray
> to another disk to a terminator. Cabling was pulled out and looked at

-- 
Stephen John Smoogen		smoogen@lanl.gov
Los Alamos National Lab  CCN-5 Sched 5/40  PH: 4-0645
Ta-03 SM-1498 MailStop B255 DP 10S  Los Alamos, NM 87545
-- So shines a good deed in a weary world. = Willy Wonka --

