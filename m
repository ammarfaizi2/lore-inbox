Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbWERNzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbWERNzi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 09:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbWERNzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 09:55:38 -0400
Received: from mail.suse.de ([195.135.220.2]:21435 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932076AbWERNzh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 09:55:37 -0400
To: Michael Ellerman <michael@ellerman.id.au>
Cc: <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC/PATCH] Make printk work for really early debugging
References: <20060518091410.CC527679F4@ozlabs.org>
From: Andi Kleen <ak@suse.de>
Date: 18 May 2006 15:55:34 +0200
In-Reply-To: <20060518091410.CC527679F4@ozlabs.org>
Message-ID: <p73y7wz30a1.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Ellerman <michael@ellerman.id.au> writes:

> Currently printk is no use for early debugging because it refuses to actually
> print anything to the console unless cpu_online(smp_processor_id()) is true.

On x86-64 this is simply solved by setting the boot processor online very early.

-Andi

