Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964808AbVJDPe3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbVJDPe3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 11:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbVJDPe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 11:34:29 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:3338 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S964810AbVJDPe2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 11:34:28 -0400
Date: Tue, 4 Oct 2005 16:34:35 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       fastboot@osdl.org
Subject: Re: [PATCH] i386: move apic init in init_IRQs
In-Reply-To: <m1fyrh8gro.fsf@ebiederm.dsl.xmission.com>
Message-ID: <Pine.LNX.4.61L.0510041628160.10696@blysk.ds.pg.gda.pl>
References: <m1fyrh8gro.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Oct 2005, Eric W. Biederman wrote:

> -	if (enable_local_apic < 0)
> -		clear_bit(X86_FEATURE_APIC, boot_cpu_data.x86_capability);

 I think this should stay.

> +	if (enable_local_apic < 0) {
> +		printk(KERN_INFO "Apic disabled\n");

 Capitalisation. ;-)

 Otherwise it seems reasonable -- provided it works for you. ;-)

  Maciej
