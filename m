Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751490AbWIVFvc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbWIVFvc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 01:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWIVFvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 01:51:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:46517 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750982AbWIVFvI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 01:51:08 -0400
From: Andi Kleen <ak@suse.de>
To: Dmitriy Zavin <dmitriyz@google.com>
Subject: Re: [PATCH 1/4] x86_64/i386 therm mce: Refactor thermal throttle processing
Date: Fri, 22 Sep 2006 07:50:14 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <11588860842488-git-send-email-dmitriyz@google.com> <11588860854079-git-send-email-dmitriyz@google.com>
In-Reply-To: <11588860854079-git-send-email-dmitriyz@google.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609220750.14948.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +#ifdef CONFIG_X86_MCE_INTEL
> +void mce_log_therm_throt_event(unsigned int cpu, __u64 status);
> +#endif

I removed that ifdef.

-Andi
