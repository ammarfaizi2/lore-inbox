Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751360AbWCBR0w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbWCBR0w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 12:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751626AbWCBR0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 12:26:52 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:17038 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750993AbWCBR0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 12:26:51 -0500
To: Paul Jackson <pj@sgi.com>
Cc: hch@infradead.org, akpm@osdl.org, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Proc: move proc fs hooks from cpuset.c to
 proc/fs/base.c
References: <20060302070812.15674.50176.sendpatchset@jackhammer.engr.sgi.com>
	<20060302084739.GC21902@infradead.org>
	<20060302062359.5940ff7f.pj@sgi.com>
	<m1y7zskdsi.fsf@ebiederm.dsl.xmission.com>
	<20060302085217.8ec38ebe.pj@sgi.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 02 Mar 2006 10:09:43 -0700
In-Reply-To: <20060302085217.8ec38ebe.pj@sgi.com> (Paul Jackson's message of
 "Thu, 2 Mar 2006 08:52:17 -0800")
Message-ID: <m1lkvskc2w.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> writes:

>> Agreed.  However the direction I am gradually moving fs/proc/base.c
>> is the opposite.
>
> Oh - ok fine.
>
> I had seen something from Andrew a couple of days ago
> that led me to a different understanding in this particular
> case.

As we increase the number of namespaces that we allow multiple instances
of in linux.  More of the files that are in /proc need to become
per process, like /proc/mounts did.

I mentioned that to Andrew and I think the message got a little
garbled.

Eric
