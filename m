Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750908AbWAOWi5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750908AbWAOWi5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 17:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750869AbWAOWi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 17:38:57 -0500
Received: from smtp-9.smtp.ucla.edu ([169.232.48.137]:25018 "EHLO
	smtp-9.smtp.ucla.edu") by vger.kernel.org with ESMTP
	id S1750775AbWAOWi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 17:38:56 -0500
Date: Sun, 15 Jan 2006 14:38:51 -0800 (PST)
From: Chris Stromsoe <cbs@cts.ucla.edu>
To: Roberto Nibali <ratz@drugphish.ch>
cc: Willy Tarreau <willy@w.ods.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: bad pmd filemap.c, oops; 2.4.30 and 2.4.32
In-Reply-To: <Pine.LNX.4.64.0601150322020.5053@potato.cts.ucla.edu>
Message-ID: <Pine.LNX.4.64.0601151431250.5053@potato.cts.ucla.edu>
References: <Pine.LNX.4.64.0512270844080.14284@potato.cts.ucla.edu>
 <20051228001047.GA3607@dmt.cnet> <Pine.LNX.4.64.0512281806450.10419@potato.cts.ucla.edu>
 <Pine.LNX.4.64.0512301610320.13624@potato.cts.ucla.edu>
 <Pine.LNX.4.64.0512301732170.21145@potato.cts.ucla.edu>
 <1136030901.28365.51.camel@localhost.localdomain> <20051231130151.GA15993@alpha.home.local>
 <Pine.LNX.4.64.0601041402340.28134@potato.cts.ucla.edu> <20060105054348.GA28125@w.ods.org>
 <Pine.LNX.4.64.0601061352510.24856@potato.cts.ucla.edu>
 <Pine.LNX.4.64.0601061411350.24856@potato.cts.ucla.edu> <43BF8785.2010703@drugphish.ch>
 <Pine.LNX.4.64.0601070246150.29898@potato.cts.ucla.edu> <43C2C482.6090904@drugphish.ch>
 <Pine.LNX.4.64.0601091221260.1900@potato.cts.ucla.edu> <43C2E243.5000904@drugphish.ch>
 <Pine.LNX.4.64.0601091654380.6479@potato.cts.ucla.edu>
 <Pine.LNX.4.64.0601150322020.5053@potato.cts.ucla.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Probable-Spam: no
X-Spam-Report: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Jan 2006, Chris Stromsoe wrote:
> On Mon, 9 Jan 2006, Chris Stromsoe wrote:
>> On Mon, 9 Jan 2006, Roberto Nibali wrote:
>> 
>>>> That is the SCSI BIOS rev.  The machine is a Dell PowerEdge 2650 and 
>>>> that's the onboard AIC 7899.  It comes up as "BIOS Build 25309".
>>> 
>>> Brain is engaged now, thanks ;). If you find time, could you maybe 
>>> compile a 2.4.32 kernel using following config (slightly changed from 
>>> yours):
>>> 
>>> http://www.drugphish.ch/patches/ratz/kernel/configs/config-2.4.32-chris_s
>> 
>> If/when the current run with DEBUG_SLAB oopses, I'll reboot with the 
>> config modifications.
>
> I've been running stable with the propsed changes since the 10th.  The 
> original config and the currently running config are both at 
> <http://hashbrown.cts.ucla.edu/pub/oops-200512/>.  This is the diff:

I made a mistake.

The machine was /not/ booted into that config.  It is running the original 
config from http://hashbrown.cts.ucla.edu/pub/oops-200512/config-2.4.32 
with DEBUG_SLAB defined and "pci=noacpi" passed in on the command line.

The config with HIGHIO disabled an ACPI=y has not been tested.


-Chris
