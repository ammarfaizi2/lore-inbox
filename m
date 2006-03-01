Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751893AbWCAUOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751893AbWCAUOL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 15:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751878AbWCAUOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 15:14:10 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:25295 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1751874AbWCAUOJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 15:14:09 -0500
Message-ID: <4406003A.1070606@cfl.rr.com>
Date: Wed, 01 Mar 2006 15:12:42 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: David Greaves <david@dgreaves.com>, Mark Lord <liml@rtr.ca>,
       Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>,
       Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       albertcc@tw.ibm.com, axboe@suse.de, Linus@vger.kernel.org
Subject: Re: LibPATA code issues / 2.6.15.4
References: <Pine.LNX.4.64.0602140439580.3567@p34>  <43F2050B.8020006@dgreaves.com> <Pine.LNX.4.64.0602141211350.10793@p34>  <200602141300.37118.lkml@rtr.ca> <440040B4.8030808@dgreaves.com>  <440083B4.3030307@rtr.ca> <Pine.LNX.4.64.0602251244070.20297@p34>  <4400A1B <1141238277.23170.2.camel@localhost.localdomain>
In-Reply-To: <1141238277.23170.2.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Mar 2006 20:15:28.0593 (UTC) FILETIME=[E21CAC10:01C63D6C]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14298.000
X-TM-AS-Result: No--2.500000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Mer, 2006-03-01 at 17:33 +0000, David Greaves wrote:
>> As a user I prefer
>>   It Broke And I Dont Know Why
>> to
>>   Aborted Command
> 
> So whats the SCSI sense encoding for that ?
> 

Wouldn't that just be 0/0/0?  IIRC the standard defines that as "NO 
ADDITIONAL SENSE DATA" which sounds to me like another way of saying "I 
don't know what went wrong, but that didn't work".


