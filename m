Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261365AbVFBKZc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbVFBKZc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 06:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261371AbVFBKZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 06:25:32 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:21449 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261365AbVFBKZ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 06:25:28 -0400
Date: Thu, 2 Jun 2005 15:53:27 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Prasanna S Panchamukhi <prasanna@in.ibm.com>
Cc: akpm@osdl.org, ak@muc.de, davem@davemloft.net, amavin@redhat.com,
       linux-kernel@vger.kernel.org, systemtap@sources.redhat.com
Subject: Re: [patch 1/1] Allow a jprobe to coexist with muliple kprobes
Message-ID: <20050602102326.GA5166@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20050602094630.GA1324@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050602094630.GA1324@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2005 at 03:16:30PM +0530, Prasanna S Panchamukhi wrote:
> Hi,
> 
> +int aggr_break_handler(struct kprobe *p, struct pt_regs *regs)
> +{
> +	struct kprobe *kp = curr_kprobe;

Any reason why this or other handler functions can't be static ?

Thanks
Dipankar
