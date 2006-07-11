Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbWGKNws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbWGKNws (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 09:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbWGKNws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 09:52:48 -0400
Received: from ns.suse.de ([195.135.220.2]:23017 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750788AbWGKNwr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 09:52:47 -0400
From: Andi Kleen <ak@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [discuss] Re: [PATCH] Allow all Opteron processors to change pstate at same time
Date: Tue, 11 Jul 2006 15:51:01 +0200
User-Agent: KMail/1.9.3
Cc: "Langsdorf, Mark" <mark.langsdorf@amd.com>,
       "Deguara, Joachim" <joachim.deguara@amd.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, cpufreq@lists.linux.org.uk
References: <84EA05E2CA77634C82730353CBE3A84303218EA4@SAUSEXMB1.amd.com> <1152624850.3128.45.camel@laptopd505.fenrus.org>
In-Reply-To: <1152624850.3128.45.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607111551.01444.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 11 July 2006 15:34, Arjan van de Ven wrote:
> 
> > Customers in the field seem to want to use TSC for gtod,
> > so I want to know how awful an idea that is.
> 
> in userspace or in the kernel?

It has to be in kernel. User space is hopeless.

> And do you happen to know why they don't want to use hpet?

HPET is slow (although not as bad as PM) too and most BIOS don't 
enable it.

-Andi
