Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbWDZQqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbWDZQqm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 12:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbWDZQqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 12:46:42 -0400
Received: from mga06.intel.com ([134.134.136.21]:51377 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750767AbWDZQql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 12:46:41 -0400
X-IronPort-AV: i="4.04,158,1144047600"; 
   d="scan'208"; a="28073886:sNHT49786618"
X-IronPort-AV: i="4.04,158,1144047600"; 
   d="scan'208"; a="28073883:sNHT48541199"
TrustInternalSourcedMail: True
X-IronPort-AV: i="4.04,158,1144047600"; 
   d="scan'208"; a="28098499:sNHT50692691"
Date: Wed, 26 Apr 2006 09:43:16 -0700
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: "mao, bibo" <bibo.mao@intel.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp>,
       Jim Keniston <jkenisto@us.ibm.com>,
       "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>,
       Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
       prasanna <prasanna@in.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
       "systemtap@sources.redhat.com" <systemtap@sources.redhat.com>
Subject: Re: [PATCH] kprobe cleanup for VM_MASK judgement
Message-ID: <20060426094316.A30732@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
References: <1146045386.29367.8.camel@maobb.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1146045386.29367.8.camel@maobb.site>; from bibo.mao@intel.com on Wed, Apr 26, 2006 at 05:56:26PM +0800
X-OriginalArrivalTime: 26 Apr 2006 16:46:24.0364 (UTC) FILETIME=[F44D3AC0:01C66950]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2006 at 05:56:26PM +0800, mao, bibo wrote:
> Hi,
> When trap happens in user space, kprobe_exceptions_notify() funtion will skip it. 
> This patch deletes some unnecessary code for VM_MASK judgement in eflags.
> 
> Signed-off-by: bibo, mao <bibo.mao@intel.com>
ACK
Acked-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
