Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751121AbWJVQUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbWJVQUT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 12:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbWJVQUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 12:20:19 -0400
Received: from mtagate5.uk.ibm.com ([195.212.29.138]:64919 "EHLO
	mtagate5.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751121AbWJVQUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 12:20:17 -0400
Date: Sun, 22 Oct 2006 18:20:14 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: yhlu <yhlu.kernel@gmail.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] x86-64: typo in __assign_irq_vector when updating pos for vector and offset
Message-ID: <20061022162013.GE4354@rhun.haifa.ibm.com>
References: <200610212100.k9LL0GtC018787@hera.kernel.org> <20061022035109.GM5211@rhun.haifa.ibm.com> <86802c440610220128v2e103912sbfba193484fb6304@mail.gmail.com> <20061022085036.GP5211@rhun.haifa.ibm.com> <86802c440610220902q648a7fc8p38fd9a3391f5bc5d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86802c440610220902q648a7fc8p38fd9a3391f5bc5d@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 22, 2006 at 09:02:19AM -0700, yhlu wrote:

> You must have NR_CPUS=4.

Nope, I have NR_CPUS=8

> Also you genapic is running on flat. (logical)

Right

> Can you try to set NR_CPUS=8 and without this patch?

All of the tests I ran were with NR_CPUS=8. Shall I try NR_CPUS=4?

Cheers,
Muli
