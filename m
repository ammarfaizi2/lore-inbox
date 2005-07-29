Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262307AbVG2DJW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262307AbVG2DJW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 23:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261945AbVG2DJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 23:09:22 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:11392 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262307AbVG2DJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 23:09:15 -0400
To: yhlu <yhlu.kernel@gmail.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86_64: sync_tsc fix the race (so we can boot)
References: <m1slxz1ssn.fsf@ebiederm.dsl.xmission.com>
	<86802c44050728092275e28a9a@mail.gmail.com>
	<86802c4405072810352d564fd3@mail.gmail.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 28 Jul 2005 21:08:40 -0600
In-Reply-To: <86802c4405072810352d564fd3@mail.gmail.com> (yhlu.kernel@gmail.com's
 message of "Thu, 28 Jul 2005 10:35:41 -0700")
Message-ID: <m1ll3q5mx3.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yhlu <yhlu.kernel@gmail.com> writes:

> I have some problem with this patch.
>
> YH
>
> On 7/28/05, yhlu <yhlu.kernel@gmail.com> wrote:
>> Do you mean solve the timing problem for 2 way dual core or 4 way
>> single core above?

As best as I can determine the problem is possible any time
you have more than 2 cpus (from the kernels perspective),
but you have ti hit a fairly narrow window in cpu start up.

What problem do you have with this patch.

Eric
