Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758037AbWK0LNV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758037AbWK0LNV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 06:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758018AbWK0LNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 06:13:21 -0500
Received: from cantor.suse.de ([195.135.220.2]:52916 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1758037AbWK0LNV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 06:13:21 -0500
To: Andy Whitcroft <apw@shadowen.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] paravirt reorder functions to avoid unspecified behaviour
References: <20061123021703.8550e37e.akpm@osdl.org>
	<6388835f69fc4a69839a132636da7188@pinky>
From: Andi Kleen <ak@suse.de>
Date: 27 Nov 2006 12:13:11 +0100
In-Reply-To: <6388835f69fc4a69839a132636da7188@pinky>
Message-ID: <p73mz6ddtx4.fsf@bingen.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Whitcroft <apw@shadowen.org> writes:

> paravirt: reorder functions to avoid unspecified behaviour
> 
> The paravirt ops introduce a 'weak' attribute onto memory_setup().
> Code ordering leads to the following warnings on x86:
> 
>     arch/i386/kernel/setup.c:651: warning: weak declaration of
> 		`memory_setup' after first use results in unspecified behavior
> 
> Move memory_setup() to avoid this.

I added the patch to the original patch thanks

-Andi
