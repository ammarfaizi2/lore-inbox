Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751342AbWB0P6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbWB0P6E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 10:58:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbWB0P6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 10:58:04 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:32463 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751342AbWB0P6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 10:58:03 -0500
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/23] proc cleanup.
References: <m1oe0yhy1w.fsf@ebiederm.dsl.xmission.com>
	<20060227152615.GA19025@sergelap.austin.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 27 Feb 2006 08:56:40 -0700
In-Reply-To: <20060227152615.GA19025@sergelap.austin.ibm.com> (Serge E.
 Hallyn's message of "Mon, 27 Feb 2006 09:26:15 -0600")
Message-ID: <m1lkvwx0av.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Serge E. Hallyn" <serue@us.ibm.com> writes:

> Quoting Eric W. Biederman (ebiederm@xmission.com):
>> 
>> When working on pid namespaces I keep tripping over /proc.
>> It's hard coded inode numbers and the amount of cruft
>> accumulated over the years makes it hard to deal with.
>> 
>> So to put /proc out of my misery here is a series of patches that
>> removes the worst of the warts.
>> 
>> The first patch which introduces task_refs is used later to address
>> one of the worst faults how much low kernel memory it allows
>
> Glad to see the task_refs patches in particular resubmitted.
>
> This is a long set including some big patches, so it's hard to just
> sit down and audit for errors, but looking at before- and after- they
> look nice.
>
> Resulting kernel passes ltp stresstests and zseries.

Very oddly there was a hickup the first time I sent them to Andrew.
So I am resending in to Andrew in slightly smaller chunks.
So far so good...

Eric
