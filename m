Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932225AbVLGEMW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbVLGEMW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 23:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbVLGEMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 23:12:22 -0500
Received: from mail.dvmed.net ([216.237.124.58]:64923 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750887AbVLGEMV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 23:12:21 -0500
Message-ID: <43966117.9040700@pobox.com>
Date: Tue, 06 Dec 2005 23:12:07 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: [PATCH 0/3] x86 PCI domain support
References: <20051203013904.GA2560@havoc.gtf.org> <20051203031533.GB14247@wotan.suse.de> <4391FC0A.9040202@pobox.com> <20051207003922.GA18528@kroah.com> <43964586.3080300@pobox.com> <20051207023305.GA19746@kroah.com>
In-Reply-To: <20051207023305.GA19746@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Greg KH wrote: > On Tue, Dec 06, 2005 at 09:14:30PM
	-0500, Jeff Garzik wrote: > >>Greg KH wrote: >> >>>On Sat, Dec 03, 2005
	at 03:11:54PM -0500, Jeff Garzik wrote: >>> >>> >>>>The first two
	patches could go in immediately, the last should probably >>>>wait a
	bit... >>> >>> >>>What is the rush? These seem pretty late for the -rc
	series :) >>> >>>I'll send them in after 2.6.15 is out, is that ok? >>
	>>You were supposed to read my mind :) "immediately" meant "ok for
	>>upstream when -rc cycle closes" :) The third patch I don't consider
	>>ready for upstream, -rc or no. > > > Ok, thanks. But I did just
	include the third patch in my tree, so it > will get tested in -mm. If
	you don't want this to happen, just let me > know and I'll drop it.
	[...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Tue, Dec 06, 2005 at 09:14:30PM -0500, Jeff Garzik wrote:
> 
>>Greg KH wrote:
>>
>>>On Sat, Dec 03, 2005 at 03:11:54PM -0500, Jeff Garzik wrote:
>>>
>>>
>>>>The first two patches could go in immediately, the last should probably 
>>>>wait a bit...
>>>
>>>
>>>What is the rush?  These seem pretty late for the -rc series :)
>>>
>>>I'll send them in after 2.6.15 is out, is that ok?
>>
>>You were supposed to read my mind :)  "immediately" meant "ok for 
>>upstream when -rc cycle closes" :)  The third patch I don't consider 
>>ready for upstream, -rc or no.
> 
> 
> Ok, thanks.  But I did just include the third patch in my tree, so it
> will get tested in -mm.  If you don't want this to happen, just let me
> know and I'll drop it.

There's no ultimate harm in it, because nothing turns on 
CONFIG_PCI_DOMAINS in x86[-64] yet...

	Jeff


