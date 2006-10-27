Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946043AbWJ0GX3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946043AbWJ0GX3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 02:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946044AbWJ0GX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 02:23:29 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:56194 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1946043AbWJ0GX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 02:23:29 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Lu, Yinghai" <yinghai.lu@amd.com>
Cc: "Muli Ben-Yehuda" <muli@il.ibm.com>, "Andi Kleen" <ak@muc.de>,
       "Andrew Morton" <akpm@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86_64 irq: reset more to default when clear irq_vector for destroy_irq
References: <5986589C150B2F49A46483AC44C7BCA412D763@ssvlexmb2.amd.com>
Date: Fri, 27 Oct 2006 00:20:40 -0600
In-Reply-To: <5986589C150B2F49A46483AC44C7BCA412D763@ssvlexmb2.amd.com>
	(Yinghai Lu's message of "Wed, 25 Oct 2006 09:40:35 -0700")
Message-ID: <m1ejsuqnyf.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Lu, Yinghai" <yinghai.lu@amd.com> writes:

> Thanks.
>
> I only found ht_irq and msi call destroy_irq. How about io_apic? 

Only on io_apic hot unplug which we don't currently support.

Eric
