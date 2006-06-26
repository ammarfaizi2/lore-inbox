Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751006AbWFZRBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbWFZRBZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 13:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbWFZRBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 13:01:16 -0400
Received: from narn.hozed.org ([209.234.73.39]:33152 "EHLO narn.hozed.org")
	by vger.kernel.org with ESMTP id S1751088AbWFZRBH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 13:01:07 -0400
Date: Mon, 26 Jun 2006 12:01:06 -0500
From: Troy Benjegerdes <hozer@hozed.org>
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: linux-kernel@vger.kernel.org,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Haren Myneni <hbabu@us.ibm.com>
Subject: Re: ppc32 with CONFIG_KEXEC broken
Message-ID: <20060626170106.GB5860@narn.hozed.org>
References: <20060626063128.GA3359@narn.hozed.org> <20060626135801.GC8985@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20060626135801.GC8985@in.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2006 at 09:58:01AM -0400, Vivek Goyal wrote:
> On Mon, Jun 26, 2006 at 01:31:28AM -0500, Troy Benjegerdes wrote:
> > various things like 'reserve_crashkernel' are referenced, but only
> > exist in arch/powerpc/kernel/machine_kexec_64.c.
> > 
> 
> I think for ppc32 the framework is present for kexec/kdump but nobody 
> is actively testing/maintaining it as of today.

Even if it's not actively being tested, introducing changes for ppc64 that
break compiles on ppc32 is going to make people unhappy.
