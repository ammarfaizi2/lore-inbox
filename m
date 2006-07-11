Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932215AbWGKW2H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbWGKW2H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 18:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbWGKW2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 18:28:07 -0400
Received: from ns1.suse.de ([195.135.220.2]:19658 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932215AbWGKW2F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 18:28:05 -0400
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: Dave Olson <olson@unixfolk.com>, <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>, discuss@x86-64.org
Subject: Re: [PATCH 2/2] Initial generic hypertransport interrupt support.
References: <m1fyh9m7k6.fsf@ebiederm.dsl.xmission.com>
	<m1bqrxm6zm.fsf@ebiederm.dsl.xmission.com>
From: Andi Kleen <ak@suse.de>
Date: 12 Jul 2006 00:27:54 +0200
In-Reply-To: <m1bqrxm6zm.fsf@ebiederm.dsl.xmission.com>
Message-ID: <p734pxnojyt.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> This patch implements two functions ht_create_irq and ht_destroy_irq
> for use by drivers.  Several other functions are implemented as helpers
> for arch specific irq_chip handlers.

What do you want to use it for? Normally all HT configuration should be handled
by the BIOS and not messed with by the kernel.

-Andi
