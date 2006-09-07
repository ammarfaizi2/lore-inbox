Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161067AbWIGSIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161067AbWIGSIz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 14:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161074AbWIGSIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 14:08:55 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:6057 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1161067AbWIGSIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 14:08:53 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] proc: Factor out an instantiate method from every lookup method.
References: <m1odttx8uz.fsf@ebiederm.dsl.xmission.com>
	<m1k64hx8rx.fsf@ebiederm.dsl.xmission.com>
	<20060907101835.de6dd2b4.akpm@osdl.org>
Date: Thu, 07 Sep 2006 12:08:11 -0600
In-Reply-To: <20060907101835.de6dd2b4.akpm@osdl.org> (Andrew Morton's message
	of "Thu, 7 Sep 2006 10:18:35 -0700")
Message-ID: <m1d5a7r1mc.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> On Wed, 06 Sep 2006 10:24:50 -0600
> ebiederm@xmission.com (Eric W. Biederman) wrote:
>
>> -/* SMP-safe */
>> ...
>> +/* SMP-safe */
>
> Not the most useful comment in the kernel, and probably untrue, given that
> it's /proc ;)
>
> Please feel free to nuke such silliness sometime.

Sure.

I remember thinking about it at some point and deciding it must have been
a left over from when someone was make /proc SMP safe.

One piece at a time.  I think I am almost done with the heavy lifting,
and the rest of the pieces can start being little cleanups.

Eric
