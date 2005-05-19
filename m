Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262464AbVESD5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262464AbVESD5O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 23:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262465AbVESD5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 23:57:14 -0400
Received: from titan.genwebhost.com ([209.9.226.66]:18883 "EHLO
	titan.genwebhost.com") by vger.kernel.org with ESMTP
	id S262464AbVESD5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 23:57:08 -0400
Message-ID: <43110.63.126.101.126.1116475020.squirrel@63.126.101.126>
In-Reply-To: <20050518220356.GC1250@wotan.suse.de>
References: <s2832b02.028@emea1-mh.id2.novell.com>
    <20050512161825.GC17618@redhat.com> <20050512214118.GA25065@redhat.com>
    <20050513132945.GB16088@wotan.suse.de>
    <20050513155241.GA3522@redhat.com> <20050518220120.GJ2596@hygelac>
    <20050518220356.GC1250@wotan.suse.de>
Date: Wed, 18 May 2005 20:57:00 -0700 (PDT)
Subject: Re: [RFC] Cachemap for 2.6.12rc4-mm1.  Was Re: [PATCH] enhance x86 
     MTRR handling
From: "Randy Dunlap" <rdunlap@xenotime.net>
To: "Andi Kleen" <ak@suse.de>
Cc: "Terence Ripperda" <tripperda@nvidia.com>, "Dave Jones" <davej@redhat.com>,
       "Andi Kleen" <ak@suse.de>, linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - titan.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [32625 32003] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: /usr/local/cpanel/3rdparty/bin/php
X-Source-Args: /usr/local/cpanel/3rdparty/bin/php /usr/local/cpanel/base/3rdparty/squirrelmail/src/compose.php 
X-Source-Dir: :/base/3rdparty/squirrelmail/src
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andi Kleen said:
>> I have no doubts that this isn't in ready condition yet. at the last
>> time I was working on this, I remember I was comparing how it behaved
>> on various systems at my disposal and there were some glaring problems
>> I was trying to take notes on. I think they were cachemap api
>> problems, but I don't recall the details. I'll try to review the
>> current code and old email to remember.
>
> I plan to do more work in this area in the future too.
>
>>
>> right now I think there were a lot of excessive printouts for
>> debugging purposes. I also have no doubts that there are coding style
>> differences that need to be cleaned up (feel free to tell me when my
>> code
>> sucks or isn't up to style).
>
> Perhaps should concentrate on the basic design first.
>
>>
>> on a side note, last I was working on this I still had to keep an
>> extra tree around and manually diff things, which is a burden and easy
>> to goof things up. is there an easier way to do this? it looks like
>> you guys are experimenting with git, is there an faq on how to get
>> started with that?
>
> I use quilt (http://quilt.sourceforge.net) for keeping patchkits.
> Works well. It is not a real SCM, but can be combined with one.

make that
  http://savannah.nongnu.org/projects/quilt

the sf.net 'quilt' says:
   Quilt  is a Java software development tool that measures  coverage....

-- 
~Randy
