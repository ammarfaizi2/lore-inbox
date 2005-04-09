Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261227AbVDIBPp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbVDIBPp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 21:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbVDIBOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 21:14:40 -0400
Received: from ds01.webmacher.de ([213.239.192.226]:65195 "EHLO
	ds01.webmacher.de") by vger.kernel.org with ESMTP id S261227AbVDIBMC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 21:12:02 -0400
In-Reply-To: <9e473391050408112865ed5d17@mail.gmail.com>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org> <20050408041341.GA8720@taniwha.stupidest.org> <Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org> <20050408071428.GB3957@opteron.random> <Pine.LNX.4.58.0504080724550.28951@ppc970.osdl.org> <4256AE0D.201@tiscali.de> <Pine.LNX.4.58.0504081010540.28951@ppc970.osdl.org> <4256BE7D.5040308@tiscali.de> <Pine.LNX.4.58.0504081047200.28951@ppc970.osdl.org> <9e473391050408112865ed5d17@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7dc90bec2ef0a67aa307b8e81005fa84@dalecki.de>
Content-Transfer-Encoding: 7bit
Cc: Chris Wedgwood <cw@f00f.org>, Andrea Arcangeli <andrea@suse.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Matthias-Christian Ott <matthias.christian@tiscali.de>
From: Marcin Dalecki <martin@dalecki.de>
Subject: Re: Kernel SCM saga..
Date: Sat, 9 Apr 2005 03:11:16 +0200
To: Jon Smirl <jonsmirl@gmail.com>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2005-04-08, at 20:28, Jon Smirl wrote:

> On Apr 8, 2005 2:14 PM, Linus Torvalds <torvalds@osdl.org> wrote:
>>    How do you replicate your database incrementally? I've given you 
>> enough
>>    clues to do it for "git" in probably five lines of perl.
>
> Efficient database replication is achieved by copying the transaction
> logs and then replaying them. Most mid to high end databases support
> this. You only need to copy the parts of the logs that you don't
> already have.
>
Databases supporting replication are called high end. You forgot the 
cats dance
around the network this issue involves.

