Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932309AbWJVJMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbWJVJMg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 05:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932310AbWJVJMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 05:12:35 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:27096 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932309AbWJVJMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 05:12:34 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Muli Ben-Yehuda <muli@il.ibm.com>
Cc: Yinghai Lu <yinghai.lu@amd.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] x86-64: typo in __assign_irq_vector when updating pos for vector and offset
References: <200610212100.k9LL0GtC018787@hera.kernel.org>
	<20061022035109.GM5211@rhun.haifa.ibm.com>
	<m1psck21fc.fsf@ebiederm.dsl.xmission.com>
	<20061022085216.GQ5211@rhun.haifa.ibm.com>
Date: Sun, 22 Oct 2006 03:10:49 -0600
In-Reply-To: <20061022085216.GQ5211@rhun.haifa.ibm.com> (Muli Ben-Yehuda's
	message of "Sun, 22 Oct 2006 10:52:16 +0200")
Message-ID: <m14ptw1zs6.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Muli Ben-Yehuda <muli@il.ibm.com> writes:

> On Sun, Oct 22, 2006 at 02:35:19AM -0600, Eric W. Biederman wrote:
>
>> Ugh.  This is no fun at all.  I am assuming this is with cpu hotplug
>> disabled in flat mode.
>
> Correct.
>
>> If my wild set of hypothesis are true the patch below might make those
>> symptoms go away.  It isn't a real fix by any means but it is an
>> easy test patch I can generate to generate these giant leaps 
>> of deduction, I'm taking in the middle of the night :)
>
> Yeap, this fixes it. Thanks to you and YL for the quick debugging!
>
> May I suggest you CC me in the future on patches in this area and I'll
> give them a quick spin before they hit mainline? less pain for
> everyone involved :-)

:)

Well we still need to fix it right so there should be a couple of more
iterations.  I need to sleep on the problem first though :)

Eric
