Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932287AbWJVIwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbWJVIwW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 04:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932291AbWJVIwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 04:52:21 -0400
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:27726 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP id S932287AbWJVIwU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 04:52:20 -0400
Date: Sun, 22 Oct 2006 10:52:16 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Yinghai Lu <yinghai.lu@amd.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] x86-64: typo in __assign_irq_vector when updating pos for vector and offset
Message-ID: <20061022085216.GQ5211@rhun.haifa.ibm.com>
References: <200610212100.k9LL0GtC018787@hera.kernel.org> <20061022035109.GM5211@rhun.haifa.ibm.com> <m1psck21fc.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1psck21fc.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 22, 2006 at 02:35:19AM -0600, Eric W. Biederman wrote:

> Ugh.  This is no fun at all.  I am assuming this is with cpu hotplug
> disabled in flat mode.

Correct.

> If my wild set of hypothesis are true the patch below might make those
> symptoms go away.  It isn't a real fix by any means but it is an
> easy test patch I can generate to generate these giant leaps 
> of deduction, I'm taking in the middle of the night :)

Yeap, this fixes it. Thanks to you and YL for the quick debugging!

May I suggest you CC me in the future on patches in this area and I'll
give them a quick spin before they hit mainline? less pain for
everyone involved :-)

Cheers,
Muli
