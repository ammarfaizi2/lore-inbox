Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162124AbWKPAmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162124AbWKPAmX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 19:42:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162120AbWKPAmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 19:42:23 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:28618 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1162119AbWKPAmW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 19:42:22 -0500
Message-ID: <455BB3E9.4000809@op5.se>
Date: Thu, 16 Nov 2006 01:42:17 +0100
From: Andreas Ericsson <ae@op5.se>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Marco Costalba <mcostalba@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] qgit-1.5.3
References: <e5bfff550611110006p44494ed4h2979232bfc8e957c@mail.gmail.com>	 <45585749.5030200@op5.se> <e5bfff550611150723p691fc480m874cce9ad4d64476@mail.gmail.com>
In-Reply-To: <e5bfff550611150723p691fc480m874cce9ad4d64476@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marco Costalba wrote:
> On 11/13/06, Andreas Ericsson <ae@op5.se> wrote:
>> Marco Costalba wrote:
>> >
>> > Download tarball from http://www.sourceforge.net/projects/qgit
>> > or directly from git public repository
>> > git://git.kernel.org/pub/scm/qgit/qgit.git
>> >
>>
>> Love the tool, but can't fetch the tag. Did you forget to
>>
>>         $ git push origin 1.5.3
>>
> 
> I think I have pushed the new tag, indeed the gitweb interface on
> kernel.org/git shows correctly the 1.5.3 tag (and also two new commits
> after that).
> 
> I've also pulled from kernel.org/git/qgit in a test repository and got
> the tag succesfully.
> 
> I'm not able to reproduce this, in any case I will push again the tags.
> 

That's odd. Here's my .git/remotes/origin
---8<---8<---8<---
URL: git://git.kernel.org/pub/scm/qgit/qgit.git
Pull: master:origin
---8<---8<---8<---

I got the tag now, by doing

$ git fetch --tags

although that didn't work last time I fetched the objects (which was 
after you had posted the announcement). Strange. This was with git 
version 1.4.3.rc3.gb32db.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
