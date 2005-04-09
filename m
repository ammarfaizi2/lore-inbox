Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbVDIByG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbVDIByG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 21:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbVDIByG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 21:54:06 -0400
Received: from warden2-p.diginsite.com ([209.195.52.120]:36518 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S261252AbVDIByB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 21:54:01 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Marcin Dalecki <martin@dalecki.de>
Cc: Jon Smirl <jonsmirl@gmail.com>, Chris Wedgwood <cw@f00f.org>,
       Andrea Arcangeli <andrea@suse.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Matthias-Christian Ott <matthias.christian@tiscali.de>
Date: Fri, 8 Apr 2005 18:50:52 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: Kernel SCM saga..
In-Reply-To: <7dc90bec2ef0a67aa307b8e81005fa84@dalecki.de>
Message-ID: <Pine.LNX.4.62.0504081849110.12437@qynat.qvtvafvgr.pbz>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
 <20050408041341.GA8720@taniwha.stupidest.org> <Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org>
 <20050408071428.GB3957@opteron.random> <Pine.LNX.4.58.0504080724550.28951@ppc970.osdl.org>
 <4256AE0D.201@tiscali.de> <Pine.LNX.4.58.0504081010540.28951@ppc970.osdl.org>
 <4256BE7D.5040308@tiscali.de> <Pine.LNX.4.58.0504081047200.28951@ppc970.osdl.org>
 <9e473391050408112865ed5d17@mail.gmail.com> <7dc90bec2ef0a67aa307b8e81005fa84@dalecki.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Apr 2005, Marcin Dalecki wrote:

> On 2005-04-08, at 20:28, Jon Smirl wrote:
>
>> On Apr 8, 2005 2:14 PM, Linus Torvalds <torvalds@osdl.org> wrote:
>>>    How do you replicate your database incrementally? I've given you enough
>>>    clues to do it for "git" in probably five lines of perl.
>> 
>> Efficient database replication is achieved by copying the transaction
>> logs and then replaying them. Most mid to high end databases support
>> this. You only need to copy the parts of the logs that you don't
>> already have.
>> 
> Databases supporting replication are called high end. You forgot the cats 
> dance
> around the network this issue involves.

And Postgres (which is Free in all senses of the word) is high end by this 
definition.

I'm not saying that it's an efficiant thing to use for this task, but 
don't be fooled into thinking you need something on the price of Oracle to 
do this job.

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
