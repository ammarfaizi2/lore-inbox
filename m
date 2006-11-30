Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759069AbWK3Ida@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759069AbWK3Ida (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 03:33:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759135AbWK3Id3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 03:33:29 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:24551 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1759069AbWK3Id3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 03:33:29 -0500
Date: Thu, 30 Nov 2006 09:31:44 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Gautham R Shenoy <ego@in.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       davej@redhat.com, dipankar@in.ibm.com, vatsa@in.ibm.com
Subject: Re: CPUFREQ-CPUHOTPLUG: Possible circular locking dependency
Message-ID: <20061130083144.GC29609@elte.hu>
References: <20061129152404.GA7082@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061129152404.GA7082@in.ibm.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=none autolearn=no SpamAssassin version=3.0.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Gautham R Shenoy <ego@in.ibm.com> wrote:

> So do we
> - Rethink the strategy of per-subsystem hotcpu-locks ?
> 
>   OR
>   
> - Think of a way to straighten out the super-convoluted cpufreq code ?

i'm still wondering what the conceptual source of this fundamental 
locking complexity in cpufreq (and hotplug) is - it is not intuitive to 
me at all. Could you try to explain that?

	Ingo
