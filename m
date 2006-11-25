Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757767AbWKYG7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757767AbWKYG7s (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 01:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757859AbWKYG7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 01:59:48 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:61606 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1757767AbWKYG7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 01:59:47 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Yinghai Lu" <yinghai.lu@amd.com>
Cc: "Andrew Morton" <akpm@osdl.org>, "Andi Kleen" <ak@muc.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86-64: change the size for interrupt array to NR_VECTORS
References: <86802c440611241736l545ddf33i3bb08f3cd6446b14@mail.gmail.com>
Date: Fri, 24 Nov 2006 23:57:52 -0700
In-Reply-To: <86802c440611241736l545ddf33i3bb08f3cd6446b14@mail.gmail.com>
	(Yinghai Lu's message of "Fri, 24 Nov 2006 17:36:59 -0800")
Message-ID: <m1psbcovwv.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Yinghai Lu" <yinghai.lu@amd.com> writes:

> Please check the patch.

YH.  Please place a newline between your subject and your description
in the body of your patches.

> [PATCH] x86_64: interrupt array size should be aligned to NR_VECTORS
>
> interrupt array is referred for idt vectors instead of NR_IRQS, so change size
> to NR_VECTORS - FIRST_EXTERNAL_VECTOR. Also change to static.
>
> Signed-off-by: Yinghai Lu <yinghai@amd.com>

Acked-by:  Eric Biederman <ebiederm@xmission.com>

Yep I missed this optimization opportunity :)

Eric
