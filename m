Return-Path: <linux-kernel-owner+w=401wt.eu-S1751065AbWLNEPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbWLNEPP (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 23:15:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbWLNEPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 23:15:15 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:45068 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065AbWLNEPO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 23:15:14 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Add allowed_affinity to the irq_desc to make it possible to have restricted irqs
References: <1166018020.27217.805.camel@laptopd505.fenrus.org>
	<m1lklbport.fsf@ebiederm.dsl.xmission.com>
	<20061213194332.GA29185@elte.hu>
	<m1ejr3pnm3.fsf@ebiederm.dsl.xmission.com>
	<45806137.4020403@linux.intel.com>
Date: Wed, 13 Dec 2006 21:14:55 -0700
In-Reply-To: <45806137.4020403@linux.intel.com> (Arjan van de Ven's message of
	"Wed, 13 Dec 2006 21:23:19 +0100")
Message-ID: <m11wn3p0zk.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@linux.intel.com> writes:

> Eric W. Biederman wrote:
>
>> There is still a question of how to handle the NUMA case but...
>>
>
> the numa case is already handled; the needed info for that is exposed already
> enough... at least for irqbalance

What is the problem you are trying to solve?

If it is just interrupts irqbalanced can't help with we can do that
with a single bit.

My basic problem with understanding what this patch is trying to
solve is that I've seen some theoretical cases raised but I don't see
the real world problem.

Eric
