Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751797AbWJVR5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797AbWJVR5c (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 13:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751798AbWJVR5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 13:57:32 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:9153 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751797AbWJVR5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 13:57:31 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Yinghai Lu" <yinghai.lu@amd.com>
Cc: "Andi Kleen" <ak@muc.de>, "Muli Ben-Yehuda" <muli@il.ibm.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86-64: using cpu_online_map instead of APIC_ALL_CPUS
References: <86802c440610220942m4fc77edbi7b6d62a2b2b378c5@mail.gmail.com>
Date: Sun, 22 Oct 2006 11:55:07 -0600
In-Reply-To: <86802c440610220942m4fc77edbi7b6d62a2b2b378c5@mail.gmail.com>
	(Yinghai Lu's message of "Sun, 22 Oct 2006 09:42:38 -0700")
Message-ID: <m1k62sz150.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Yinghai Lu" <yinghai.lu@amd.com> writes:

> Using cpu_online_map instead of APIC_ALL_CPUS for flat apic mode, So
> __assign_irq_vector can refer correct per_cpu data.
>
> Cc: Muli Ben-Yehuda <muli@il.ibm.com>
> Signed-off-by: Yinghai Lu <yinghai.lu@amd.com>

Nack.  This fixes the symptom not the bug.
More comprehensive patches follow.

Eric

