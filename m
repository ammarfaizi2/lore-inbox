Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286649AbSABCag>; Tue, 1 Jan 2002 21:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286650AbSABCa1>; Tue, 1 Jan 2002 21:30:27 -0500
Received: from [208.179.59.195] ([208.179.59.195]:21332 "EHLO
	Booterz.killerlabs.com") by vger.kernel.org with ESMTP
	id <S286649AbSABCaQ>; Tue, 1 Jan 2002 21:30:16 -0500
Message-ID: <3C327009.8040606@blue-labs.org>
Date: Tue, 01 Jan 2002 21:27:21 -0500
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20011231
X-Accept-Language: en-us
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: Stewart Smith <stewart@softhome.net>, timothy.covell@ashavan.org,
        linux-kernel@vger.kernel.org
Subject: Re: RFC: Linux Bug Tracking & Feature Tracking DB
In-Reply-To: <Pine.LNX.4.33.0112312048160.17274-100000@Appserv.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>>Starting a browser is equivalent to starting a mail client.  In some
>>instances it's the same program.
>>
>
>keeping a terminal with ssh open all day is feasible (and is what I
>and a lot of others probably do). Keeping mozilla open all day is
>not practical. (and no, w3m/lynx etc are not practical for using
>bugzilla imo).
>

Eh?  Why isn't it?  I keep it open for weeks if it doesn't crash.

>>Hitting 2-3 keypresses to archive an email...how do you manage that
>>archive v.s. it being managed for you w/ bugzilla?
>>
>
>both mua's I use have comprehensive indexing/searching abilities.
>s25<enter> saves a patch for applying later.
>
>cat ~/25 | patch -p1  is all I need to do, plus I have an archive
>of patches applied on what date, along with the descriptive mails
>that went with them.
>
>Effortless.
>
>If a patch needs reversing, I load the mua, move the mail to another
>folder, and do the same with patch -R
>
>Dave.
>

Then your system works for you, but it doesn't make anything available 
for anyone else nor does it allow for anything other than the simple 
collection of emails/patches.  That's the point of an accessible 
database.  Over years of development, trying to maintain a comprehensive 
system would require you to index what "25" relates to.

The point of this DB in discussion is to make it easier for everyone, 
from developer to the random person who only reads lkml when he needs to 
find an answer.  Make it easier to research, catalog, reference, 
explain, and derive all the parts of a given bug.

For example, the ECN issue.  Anyone from developer to Joe Admin could 
look up "connection failed" and get back a group of results with a high 
"ECN" hit rate.  A few seconds to type it in and a minute later he has 
probably put 0 in tcp_ecn and happily wanders away.

David


