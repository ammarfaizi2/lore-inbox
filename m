Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269059AbUJUDEF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269059AbUJUDEF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 23:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269097AbUJUDAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 23:00:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:13971 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270460AbUJUCwj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 22:52:39 -0400
Message-ID: <4177237D.8070502@osdl.org>
Date: Wed, 20 Oct 2004 19:48:29 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adam Hunt <kinema@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: I/O scheduler recomendation for Linux as a VMware guest
References: <b476569a0410201616415b0600@mail.gmail.com>
In-Reply-To: <b476569a0410201616415b0600@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Hunt wrote:
> I am forced to spend quite a bit of time with my only relatively
> powerful workstation booted into XP so I can do CAD work
> (unfortunately Autodesk's Inventor only runs on Windows).  Because of
> this unfortunate situation I am planning my first attempt to get the
> Linux install that I have on the other drive in this workstation to
> boot using VMware.  VMware has the ability to access raw disk
> partitions (as apposed to partitions stored in a file on a host
> partition) so I figure with some init and /etc magic I should be able
> to boot the system using VMware and when I am not drawing in Inventor
> I should be able to reboot and run Linux natively directly on the
> hardware.
> 
> What I am wondering is what I/O scheduler should I be using when the
> system is running within a VMware instance?  I figure that Windows
> will be scheduling the access to the physical hardware so I would
> assume that I want a bare bones priority based scheduler, something
> with the lowest possible overhead.  Is this correct?  If so, what
> would that scheduler be?
> 
> IIRC someone (Ingo?) was working on the ability to change schedules
> during runtime.  How has that work progressed?  Is it available in any
> kernel trees?

It was Jens Axboe.

It was merged _after_ 2.6.9, so it's currently available in
2.6.9-bkN.  See this BK changeset (and the lwn.net article that
is referred to there):

http://linux.bkbits.net:8080/linux-2.5/cset@41752c48DmUvWjzNzOcvM8RlMCIF4A?nav=index.html|ChangeSet@-4w

-- 
~Randy
