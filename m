Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758807AbWK2JIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758807AbWK2JIb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 04:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758806AbWK2JIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 04:08:30 -0500
Received: from mga09.intel.com ([134.134.136.24]:14352 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S1758807AbWK2JI3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 04:08:29 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,473,1157353200"; 
   d="scan'208"; a="20911651:sNHT18953883"
Subject: Re: [patch] Mark rdtsc as sync only for netburst, not for core2
From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <456D4648.7000509@linux.intel.com>
References: <1164709708.3276.72.camel@laptopd505.fenrus.org>
	 <200611281136.29066.ak@suse.de> <1164774239.15257.5.camel@ymzhang>
	 <456D372C.9080800@linux.intel.com> <1164787104.2899.7.camel@ymzhang>
	 <456D4648.7000509@linux.intel.com>
Content-Type: text/plain
Date: Wed, 29 Nov 2006 17:07:48 +0800
Message-Id: <1164791268.2873.5.camel@ymzhang>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-29 at 09:35 +0100, Arjan van de Ven wrote:
> Zhang, Yanmin wrote:
> >> but second of all, the core2 cpus are dual core so.. .what does it 
> >> bring you at all?
> > 
> > When there is only one cpu (or UP), the go backwards issue doesn't exist,
> 
> it does exist for single-socket dual core already. And core2 is dual 
> core...
> 
> > so
> > don't use cpuid here for UP. Another function init_amd already does so.
> > 
> not anymore.. that got fixed very recently...
Thanks.

> (but you are right; on AMD the speculation is even bigger so there 
> even on single core you need cpuid)
