Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261872AbSKCNt6>; Sun, 3 Nov 2002 08:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261874AbSKCNt5>; Sun, 3 Nov 2002 08:49:57 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:29368 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261872AbSKCNtS>; Sun, 3 Nov 2002 08:49:18 -0500
Cc: "David D. Hagood" <wowbagger@sktc.net>,
       Rik van Riel <riel@conectiva.com.br>, "Theodore Ts'o" <tytso@mit.edu>,
       Dax Kelson <dax@gurulabs.com>, Rusty Russell <rusty@rustcorp.com.au>,
       <linux-kernel@vger.kernel.org>, <davej@suse.de>
References: <Pine.LNX.4.44.0211021803240.2300-100000@home.transmeta.com>
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Filesystem Capabilities in 2.6?
Date: Sun, 03 Nov 2002 14:55:39 +0100
Message-ID: <87heeysqp0.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> On Sat, 2 Nov 2002, David D. Hagood wrote:
>> Linus Torvalds wrote:
>> 
>> Would this not allow a user to add permissions to a file, by creating a 
>> new directory entry and linking it to an existing inode?
>> 
>> Would that not be a greater security hole?
>
> No. The file itself has _no_ capabilities at all. If you just link to it,
> you can give it whatever capabilities _you_ have as a user (well, normal
> users don't really have any capabilities to give, but you get the idea).

So, this would be the inheritable set only.

Regards, Olaf.
