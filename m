Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751139AbWBZRDu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbWBZRDu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 12:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbWBZRDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 12:03:50 -0500
Received: from rtr.ca ([64.26.128.89]:35713 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750886AbWBZRDt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 12:03:49 -0500
Message-ID: <4401DF6B.9010409@rtr.ca>
Date: Sun, 26 Feb 2006 12:03:39 -0500
From: Mark Lord <liml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: David Greaves <david@dgreaves.com>,
       Justin Piszcz <jpiszcz@lucidpixels.com>,
       Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       albertcc@tw.ibm.com, axboe@suse.de, htejun@gmail.com
Subject: Re: Kernel SeekCompleteErrors... Different from Re: LibPATA code
 issues / 2.6.15.4
References: <Pine.LNX.4.64.0602140439580.3567@p34> <43F2050B.8020006@dgreaves.com> <Pine.LNX.4.64.0602141211350.10793@p34> <200602141300.37118.lkml@rtr.ca> <440040B4.8030808@dgreaves.com> <440083B4.3030307@rtr.ca> <Pine.LNX.4.64.0602251244070.20297@p34> <4400A1BF.7020109@rtr.ca> <4400B439.8050202@dgreaves.com> <4401122A.3010908@rtr.ca> <44019E96.20804@superbug.co.uk> <4401B378.3030005@rtr.ca> <4401BB85.7070407@superbug.co.uk>
In-Reply-To: <4401BB85.7070407@superbug.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Courtier-Dutton wrote:
> Mark Lord wrote:
>> James Courtier-Dutton wrote:
>>>
>>> I have what looks like similar problems. The issue I have is that I 
>>
>> Nope.  Different issues.
> I have changed the Subject line to indicate this so any future responses 
> can be indicated.
> 
>>
>>> ) #1 Sat Dec 3 18:47:19 GMT 2005
>>> Dec 16 22:51:57 games kernel: hdc: dma_intr: status=0x51 { DriveReady 
>>> SeekComplete Error }
>>> Dec 16 22:52:32 games kernel: hdc: dma_intr: error=0x40 { 
>>> UncorrectableError }, LBAsect=53058185, sector=53057951
>>
>> The disk really does have bad sectors in this case (above).
> The disk has NO bad sectors. It has been checked using two different tests.

The *only* test that matters is to enable S.M.A.R.T.,
and read out the error logs from it.

"smartctl" is the tool.

Cheers
