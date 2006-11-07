Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754147AbWKGJnb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754147AbWKGJnb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 04:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754151AbWKGJnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 04:43:31 -0500
Received: from mga07.intel.com ([143.182.124.22]:8773 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1754147AbWKGJna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 04:43:30 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,395,1157353200"; 
   d="scan'208"; a="142327033:sNHT26970314"
Message-ID: <45505531.4080909@linux.intel.com>
Date: Tue, 07 Nov 2006 10:43:13 +0100
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Shaohua Li <shaohua.li@intel.com>, linux-kernel@vger.kernel.org,
       bunk@stusta.de
Subject: Re: [patch] Regression in 2.6.19-rc microcode driver
References: <1162822538.3138.28.camel@laptopd505.fenrus.org>	<1162862427.22565.4.camel@sli10-conroe.sh.intel.com>	<20061106175914.a9491eab.akpm@osdl.org>	<45504E2D.80504@linux.intel.com> <20061107012137.a99fab3b.akpm@osdl.org>
In-Reply-To: <20061107012137.a99fab3b.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Tue, 07 Nov 2006 10:13:17 +0100
> Arjan van de Ven <arjan@linux.intel.com> wrote:
> 
>>> Due to the timeout?  So it should come back after 10*num_online_cpus seconds?
>>>
>>> Does Arjan have a lot of CPUs?
>> eh yes, my test machine has quite a large number of those.
> 
> So did it really hang?

ok so it eventually continues.. just way past my "it hang" patience 
window of about a minute
