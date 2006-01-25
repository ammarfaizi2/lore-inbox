Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750994AbWAYOTv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbWAYOTv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 09:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbWAYOTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 09:19:50 -0500
Received: from rogue.ncsl.nist.gov ([129.6.101.41]:17126 "EHLO
	rogue.ncsl.nist.gov") by vger.kernel.org with ESMTP
	id S1750994AbWAYOTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 09:19:50 -0500
From: Ian Soboroff <isoboroff@acm.org>
To: Max Waterman <davidmaxwaterman@fastmail.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: io performance...
References: <43CB4CC3.4030904@fastmail.co.uk> <43CD2405.4070902@cfl.rr.com>
	<43CDED23.5060701@fastmail.co.uk> <43CE5C7A.5060608@cfl.rr.com>
	<43D07C08.5000903@fastmail.co.uk> <9cfek33vwvo.fsf@nist.gov>
	<43D71C75.2050807@fastmail.co.uk>
Date: Wed, 25 Jan 2006 09:19:39 -0500
In-Reply-To: <43D71C75.2050807@fastmail.co.uk> (Max Waterman's message of
	"Wed, 25 Jan 2006 14:36:37 +0800")
Message-ID: <9cfek2wz8xw.fsf@rogue.ncsl.nist.gov>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Max Waterman <davidmaxwaterman@fastmail.co.uk> writes:

>>> We're still wondering why rd performance is so low - seems to be the
>>> same as a single drive. RAID10 should be the same performance as RAID0
>>> over two drives, shouldn't it?
>>>
>> I think bonnie++ measures accesses to many small files (INN-like
>> simulation) and database accesses.  These are random accesses, which
>> is the worst access pattern for RAID.  Seek time in a RAID equals the
>> longest of all the drives in the RAID, rather than the average.  So
>> bonnie++ is domninated by your seek time.
>
> You think so? I had assumed when bonnie++'s output said 'sequential
> access' that it was the opposite of random, for example (raid0 on 5
> drives) :
>

I could be wrong, I was just reading the information from the bonnie++
website... 

Ian

