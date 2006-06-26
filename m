Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030215AbWFZN6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030215AbWFZN6c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 09:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030216AbWFZN6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 09:58:32 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:9894 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030215AbWFZN6b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 09:58:31 -0400
Date: Mon, 26 Jun 2006 09:58:01 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Troy Benjegerdes <hozer@hozed.org>
Cc: linux-kernel@vger.kernel.org,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Haren Myneni <hbabu@us.ibm.com>
Subject: Re: ppc32 with CONFIG_KEXEC broken
Message-ID: <20060626135801.GC8985@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060626063128.GA3359@narn.hozed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060626063128.GA3359@narn.hozed.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2006 at 01:31:28AM -0500, Troy Benjegerdes wrote:
> various things like 'reserve_crashkernel' are referenced, but only
> exist in arch/powerpc/kernel/machine_kexec_64.c.
> 

I think for ppc32 the framework is present for kexec/kdump but nobody 
is actively testing/maintaining it as of today.

Thanks
Vivek
