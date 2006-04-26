Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964775AbWDZR5A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964775AbWDZR5A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 13:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbWDZR47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 13:56:59 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:34482 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932329AbWDZR47 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 13:56:59 -0400
Date: Wed, 26 Apr 2006 23:27:06 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: "mao, bibo" <bibo.mao@intel.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp>,
       Jim Keniston <jkenisto@us.ibm.com>,
       "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>,
       Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>,
       "systemtap@sources.redhat.com" <systemtap@sources.redhat.com>
Subject: Re: [PATCH] kprobe cleanup for VM_MASK judgement
Message-ID: <20060426175706.GB10043@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <1146045386.29367.8.camel@maobb.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1146045386.29367.8.camel@maobb.site>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
> When trap happens in user space, kprobe_exceptions_notify() funtion will skip it. 
> This patch deletes some unnecessary code for VM_MASK judgement in eflags.
> 
> Signed-off-by: bibo, mao <bibo.mao@intel.com>

Looks good to me.

Thanks
Prasanna
-- 
Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Email: prasanna@in.ibm.com
Ph: 91-80-51776329
