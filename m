Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751561AbWJMRrV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561AbWJMRrV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 13:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751564AbWJMRrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 13:47:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40342 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751508AbWJMRrT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 13:47:19 -0400
Date: Fri, 13 Oct 2006 10:47:14 -0700
From: Judith Lebzelter <judith@osdl.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, Judith Lebzelter <judith@osdl.org>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IA64 export symbols empty_zero_page, ia64_ssc
Message-ID: <20061013174714.GA822@shell0.pdx.osdl.net>
References: <617E1C2C70743745A92448908E030B2AA634B8@scsmsx411.amr.corp.intel.com> <20061012001139.1fea6ecf.akpm@osdl.org> <20061012175536.GA8497@intel.com> <20061012123714.85ab4ebb.akpm@osdl.org> <20061012210033.GA9669@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061012210033.GA9669@intel.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2006 at 02:00:33PM -0700, Luck, Tony wrote:
> [IA64] Fix allmodconfig build
> 
> The HP_SIMSCSI driver can't be built as a module (unhealthy
> dependencies on things that shouldn't really be exported).
> 
> AMD and nVidia IDE support doesn't sound too useful for ia64
> either :-)

Thanks for doing this.  I run cross compiles and do not always 
know what is the best fix for the architecture.  I have been trying
to address some of these errors so that the compiles for 'allmodconfig' 
will be less 'noisy' and easier to get value out of. 

Judith

