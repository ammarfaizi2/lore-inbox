Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751225AbVHLQmq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbVHLQmq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 12:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbVHLQmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 12:42:46 -0400
Received: from ns2.suse.de ([195.135.220.15]:61153 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751225AbVHLQmp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 12:42:45 -0400
Date: Fri, 12 Aug 2005 18:42:44 +0200
From: Andi Kleen <ak@suse.de>
To: yhlu <yhlu.kernel@gmail.com>
Cc: Andi Kleen <ak@suse.de>, Martin Wilck <martin.wilck@fujitsu-siemens.com>,
       linux-kernel@vger.kernel.org
Subject: Re: APIC version and 8-bit APIC IDs
Message-ID: <20050812164244.GC22901@wotan.suse.de>
References: <42FC8461.2040102@fujitsu-siemens.com.suse.lists.linux.kernel> <p73pssj2xdz.fsf@verdi.suse.de> <42FCA23C.7040601@fujitsu-siemens.com> <20050812133248.GN8974@wotan.suse.de> <42FCA97E.5010907@fujitsu-siemens.com> <42FCB86C.5040509@fujitsu-siemens.com> <20050812145725.GD922@wotan.suse.de> <86802c44050812093774bf4816@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86802c44050812093774bf4816@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2005 at 09:37:11AM -0700, yhlu wrote:
> So MPTABLE do not have problem with it, only acpi related...?

It's only a cosmetic problem I think with the printk being
wrong. The actual decision in the code should all use the true
value.

Another way would be to just remove the printk output.

-Andi
