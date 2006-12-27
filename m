Return-Path: <linux-kernel-owner+w=401wt.eu-S1754709AbWL0U1W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754709AbWL0U1W (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 15:27:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754721AbWL0U1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 15:27:22 -0500
Received: from mga05.intel.com ([192.55.52.89]:12109 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754709AbWL0U1V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 15:27:21 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,212,1165219200"; 
   d="scan'208"; a="182219980:sNHT17960607"
Date: Wed, 27 Dec 2006 11:58:55 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Martin Knoblauch <knobi@knobisoft.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to detect multi-core and/or HT-enabled CPUs in 2.4.x and 2.6.x kernels
Message-ID: <20061227115854.C23645@unix-os.sc.intel.com>
References: <1167235772.3281.3977.camel@laptopd505.fenrus.org> <681548.1013.qm@web32601.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <681548.1013.qm@web32601.mail.mud.yahoo.com>; from knobi@knobisoft.de on Wed, Dec 27, 2006 at 09:52:02AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 27, 2006 at 09:52:02AM -0800, Martin Knoblauch wrote:
>  For sizing purposes, doing benchmarks is the only way. For the purpose
> of Ganglia the sockets/cores/threads info is purely for inventory. And
> we are likely going to add the new information to our metrics.
> 
>  But - we still need to find a way to extract the infor :-)

Only the 2.4 x86_64 kernels are exporting limited info("physical id",
"siblings") through /proc/cpuinfo.

Some of the distos based on 2.4 kernels have the complete topology
(physical id, core id, cpu cores, siblings) exported through /proc/cpuinfo.

thanks,
suresh
