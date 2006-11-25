Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757857AbWKYG5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757857AbWKYG5L (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 01:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757858AbWKYG5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 01:57:10 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:59046 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1757857AbWKYG5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 01:57:09 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Yinghai Lu" <yinghai.lu@amd.com>
Cc: "Andrew Morton" <akpm@osdl.org>, "Andi Kleen" <ak@muc.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] x86-64: calling clear_bss before set_intr_gate with early_idt_handler
References: <86802c440611241730l55e81294u21944b528d95c15d@mail.gmail.com>
Date: Fri, 24 Nov 2006 23:55:04 -0700
In-Reply-To: <86802c440611241730l55e81294u21944b528d95c15d@mail.gmail.com>
	(Yinghai Lu's message of "Fri, 24 Nov 2006 17:30:18 -0800")
Message-ID: <m1u00oow1j.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Yinghai Lu" <yinghai.lu@amd.com> writes:

> Please check the patch.
>
> [PATCH] x86_64: clear_bss before set_intr_gate with early_idt_handler
> idt_table is in the .bss section, so clear_bss need to called at first
>
> Signed-off-by: Yinghai Lu <yinghai.lu@amd.com> 

Acked-by: Eric Biederman <ebiederm@xmission.com>

The only problem I have might be the description would read more
clearly as:
 [PATCH] x86_64: call clear_bss before set_intr_gate with early_idt_handler

 idt_table is in the .bss section, so clear_bss need to called first

Eric
