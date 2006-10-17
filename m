Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751392AbWJQS1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbWJQS1d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 14:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbWJQS1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 14:27:33 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:31201 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751392AbWJQS1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 14:27:33 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Lu, Yinghai" <yinghai.lu@amd.com>
Cc: "Linus Torvalds" <torvalds@osdl.org>, "Andrew Morton" <akpm@osdl.org>,
       "Andi Kleen" <ak@suse.de>, linux-kernel@vger.kernel.org,
       "Natalie Protasevich" <Natalie.Protasevich@UNISYS.com>
Subject: Re: [PATCH] x86_64 irq: Use irq_domain in ioapic_retrigger_irq
References: <5986589C150B2F49A46483AC44C7BCA412D6F8@ssvlexmb2.amd.com>
Date: Tue, 17 Oct 2006 12:25:47 -0600
In-Reply-To: <5986589C150B2F49A46483AC44C7BCA412D6F8@ssvlexmb2.amd.com>
	(Yinghai Lu's message of "Tue, 17 Oct 2006 11:09:28 -0700")
Message-ID: <m1hcy294us.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Lu, Yinghai" <yinghai.lu@amd.com> writes:

> Can you change "unsigned vector" to "int vector" like other function?

It doesn't matter it is an 8 bit unsigned value.
So I made the minimal change necessary to get the bugs fixed.

Coping with the inconsistencies of the usage can be a separate patch.
That way we won't get functional and style changes confused.

Eric
