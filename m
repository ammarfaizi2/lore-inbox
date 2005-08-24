Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbVHXBz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbVHXBz7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 21:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbVHXBz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 21:55:59 -0400
Received: from fmr19.intel.com ([134.134.136.18]:60592 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750725AbVHXBz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 21:55:58 -0400
Subject: Re: [PATCH] Add MCE resume under ia32
From: Shaohua Li <shaohua.li@intel.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <p73pss4f6dj.fsf@verdi.suse.de>
References: <1124762500.3013.3.camel@linux-hp.sh.intel.com.suse.lists.linux.kernel>
	 <20050823103256.GB2795@elf.ucw.cz.suse.lists.linux.kernel>
	 <1124846001.3007.7.camel@linux-hp.sh.intel.com.suse.lists.linux.kernel>
	 <p73pss4f6dj.fsf@verdi.suse.de>
Content-Type: text/plain
Date: Wed, 24 Aug 2005 09:59:00 +0800
Message-Id: <1124848740.3622.1.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-24 at 03:52 +0200, Andi Kleen wrote:
> Shaohua Li <shaohua.li@intel.com> writes:
> 
> > x86-64 has resume support. It uses 'on_each_cpu' in resume method, which
> > is known broken. We'd better fix it.
> 
> What is broken with it? 
It's a sysdev. The resume method is invoked with interrupt disabled.

Thanks,
Shaohua

