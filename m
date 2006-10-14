Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932160AbWJNKIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbWJNKIw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 06:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752097AbWJNKIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 06:08:52 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:4515 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1752064AbWJNKIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 06:08:51 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Yinghai Lu" <yinghai.lu@amd.com>
Cc: "Andi Kleen" <ak@muc.de>,
       "linux kernel mailing list" <linux-kernel@vger.kernel.org>,
       yhlu.kernel@gmail.com
Subject: Re: [PATCH] x86_64: using irq_domain in ioapic_retrigger_irq
References: <86802c440610140201h5edd9ceay454cc192583a69c1@mail.gmail.com>
Date: Sat, 14 Oct 2006 04:06:49 -0600
In-Reply-To: <86802c440610140201h5edd9ceay454cc192583a69c1@mail.gmail.com>
	(Yinghai Lu's message of "Sat, 14 Oct 2006 02:01:57 -0700")
Message-ID: <m1d58vfbye.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Yinghai Lu" <yinghai.lu@amd.com> writes:

> using irq_domain[irq] to get cpu_mask for send_IPI_mask

Yep.  I missed that one in my last refactoring :(

Acked-by: Eric W. Biederman <ebiederm@xmission.com>

Eric
