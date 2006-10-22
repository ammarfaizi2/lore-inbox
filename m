Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932293AbWJVJAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbWJVJAW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 05:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbWJVJAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 05:00:22 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:54470 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932293AbWJVJAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 05:00:21 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Muli Ben-Yehuda <muli@il.ibm.com>
Cc: Yinghai Lu <yinghai.lu@amd.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] x86-64: typo in __assign_irq_vector when updating pos for vector and offset
References: <200610212100.k9LL0GtC018787@hera.kernel.org>
	<20061022035109.GM5211@rhun.haifa.ibm.com>
	<86802c440610220128v2e103912sbfba193484fb6304@mail.gmail.com>
	<20061022085036.GP5211@rhun.haifa.ibm.com>
Date: Sun, 22 Oct 2006 02:58:18 -0600
In-Reply-To: <20061022085036.GP5211@rhun.haifa.ibm.com> (Muli Ben-Yehuda's
	message of "Sun, 22 Oct 2006 10:50:36 +0200")
Message-ID: <m1d58k20d1.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Muli Ben-Yehuda <muli@il.ibm.com> writes:

> Works!

Cool so we have a work around.

So it looks like we need to be a little more careful with vector_irq,
and it's initialization when cpus start up, or are not running.

Eric
