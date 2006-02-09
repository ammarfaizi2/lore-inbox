Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422749AbWBIKU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422749AbWBIKU2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 05:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422877AbWBIKU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 05:20:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:19885 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422749AbWBIKU1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 05:20:27 -0500
Date: Thu, 9 Feb 2006 02:13:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: 76306.1226@compuserve.com, pj@sgi.com, wli@holomorphy.com, ak@muc.de,
       mingo@elte.hu, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       riel@redhat.com, dada1@cosmobay.com
Subject: Re: [PATCH] percpu data: only iterate over possible CPUs
Message-Id: <20060209021314.23a9096f.akpm@osdl.org>
In-Reply-To: <20060209100834.GA9281@osiris.boeblingen.de.ibm.com>
References: <200602090335_MC3-1-B7FA-621E@compuserve.com>
	<20060209010655.5cdeb192.akpm@osdl.org>
	<20060209011106.68aa890a.akpm@osdl.org>
	<20060209100834.GA9281@osiris.boeblingen.de.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
>
> > > aargh.
>  > Actually, x86 appears to be the only arch which suffers this braindamage. 
>  > The rest use CPU_MASK_NONE (or just forget to initialise it and hope that
>  > CPU_MASK_NONE equals all-zeroes).
> 
>  s390 will join, as soon as the cpu_possible_map fix is merged...

What cpu_possible_map fix?
