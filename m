Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422742AbWBIKIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422742AbWBIKIp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 05:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422743AbWBIKIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 05:08:45 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:28123 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1422742AbWBIKIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 05:08:45 -0500
Date: Thu, 9 Feb 2006 11:08:34 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: 76306.1226@compuserve.com, pj@sgi.com, wli@holomorphy.com, ak@muc.de,
       mingo@elte.hu, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       riel@redhat.com, dada1@cosmobay.com
Subject: Re: [PATCH] percpu data: only iterate over possible CPUs
Message-ID: <20060209100834.GA9281@osiris.boeblingen.de.ibm.com>
References: <200602090335_MC3-1-B7FA-621E@compuserve.com> <20060209010655.5cdeb192.akpm@osdl.org> <20060209011106.68aa890a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060209011106.68aa890a.akpm@osdl.org>
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > aargh.
> Actually, x86 appears to be the only arch which suffers this braindamage. 
> The rest use CPU_MASK_NONE (or just forget to initialise it and hope that
> CPU_MASK_NONE equals all-zeroes).

s390 will join, as soon as the cpu_possible_map fix is merged...

Heiko
