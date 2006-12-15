Return-Path: <linux-kernel-owner+w=401wt.eu-S964959AbWLOVFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964959AbWLOVFP (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 16:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964960AbWLOVFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 16:05:14 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:53078 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964959AbWLOVFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 16:05:13 -0500
Date: Fri, 15 Dec 2006 22:01:10 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@lazybastard.org>,
       Randy Dunlap <randy.dunlap@oracle.com>, Pavel Machek <pavel@ucw.cz>,
       Scott Preece <sepreece@gmail.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH/v2] CodingStyle updates
In-Reply-To: <d120d5000612151256h5428eddcpbd137ce939a58b32@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0612152158240.28506@yvahk01.tjqt.qr>
References: <20061207165508.e6bf0269.randy.dunlap@oracle.com> 
 <20061215120942.GA4551@ucw.cz> <4582AEC8.7030608@s5r6.in-berlin.de> 
 <20061215142206.GC2053@elf.ucw.cz>  <7b69d1470612150652p609c38d2n9bff58bdb0a1edb7@mail.gmail.com>
  <20061215150717.GA2345@elf.ucw.cz>  <20061215090037.05c021af.randy.dunlap@oracle.com>
  <20061215201127.GA32210@lazybastard.org> <d120d5000612151256h5428eddcpbd137ce939a58b32@mail.gmail.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1283855629-1877360553-1166216470=:28506"
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1283855629-1877360553-1166216470=:28506
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT


On Dec 15 2006 15:56, Dmitry Torokhov wrote:
> On 12/15/06, Jörn Engel <joern@lazybastard.org> wrote:
>> On Fri, 15 December 2006 09:00:37 -0800, Randy Dunlap wrote:
>> > On Fri, 15 Dec 2006 16:07:17 +0100 Pavel Machek wrote:
>> > 
>> > > Not in simple cases.
>> > > 
>> > > 3*i + 2*j should be writen like that. Not like
>> > > (3 * i) + (2 * j)
>> > 
>> > I would just write it as:
>> > 3 * i + 2 * j
>> 
>> So would I.  But I definitely wouldn't write
>>       for (i = 0; i < 10; i += 2)
>> because I prefer the grouping in
>> for (i=0; i<10; i+=2)
>> 
>
> Would you write:
>
>      i+=2;
>
> outside the loop? If not then it is better to keep style consistent
> and not use condensed form in loops either.

Don't you all even think about leaving the whitespace away in the wrong
place, otherwise the kernel is likely to become an entry for IOCCC.


	-`J'
-- 
--1283855629-1877360553-1166216470=:28506--
