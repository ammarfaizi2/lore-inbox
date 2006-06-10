Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932605AbWFJANU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932605AbWFJANU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 20:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932603AbWFJANU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 20:13:20 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:59818 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932602AbWFJANT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 20:13:19 -0400
Message-ID: <448A0E96.3030005@garzik.org>
Date: Fri, 09 Jun 2006 20:13:10 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Olivier Galibert <galibert@pobox.com>, Jeff Garzik <jeff@garzik.org>,
       Alex Tomas <alex@clusterfs.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org, Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com> <4488E1A4.20305@garzik.org> <20060609083523.GQ5964@schatzie.adilger.int> <44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org> <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org> <m33beecntr.fsf@bzzz.home.net> <Pine.LNX.4.64.0606090913390.5498@g5.osdl.org> <m3k67qb7hr.fsf@bzzz.home.net> <4489A7ED.8070007@garzik.org> <20060610000734.GA56336@dspnet.fr.eu.org>
In-Reply-To: <20060610000734.GA56336@dspnet.fr.eu.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olivier Galibert wrote:
> On Fri, Jun 09, 2006 at 12:55:09PM -0400, Jeff Garzik wrote:
>> Alex Tomas wrote:
>>> so, instead of taking one (quite-well-tested) part that solves one of
>>> the biggest ext3 limitation, you propose to start a new project and
>>> get something in a year (probably) ?
>>>
>>> I think about extents as a step-by-step way ...
>> That is what the entirety of Linux development is -- step-by-step.
>>
>> It is OBVIOUS that it would take five minutes to start ext4.
>>
>> 1) clone a new tree
>> 2) cp -a fs/ext3 fs/ext4
>> 3) apply extent and 48bit patches
>> 4) apply related e2fsprogs patches
> 
> 5) force all options (attributes, etc) on and remove the flags
>    indicating their existence from the metadata, you'll need the space
>    for the fs evolution.
> 
> 6) change the fs just enough so that an ext4 fs can never be mounted
>    as ext3 or 2.

Yeah.  And its easy enough just to change the main magic number...

	Jeff



