Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265784AbUHFPVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265784AbUHFPVu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 11:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268138AbUHFPVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 11:21:50 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42630 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265784AbUHFPTA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 11:19:00 -0400
Date: Fri, 6 Aug 2004 11:33:59 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Vladislav Bolkhovitin <vst@vlnb.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 bitops.h commentary on instruction reordering
Message-ID: <20040806143359.GC20911@logos.cnet>
References: <20040805200622.GA17324@logos.cnet> <411392E0.6080507@vlnb.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <411392E0.6080507@vlnb.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2004 at 06:17:04PM +0400, Vladislav Bolkhovitin wrote:
> So, is there any way to workaround this problem, i.e. prevent bit 
> operations reordering on non-x86 architectures? Some kinds of memory 
> barriers?

Memory barriers, yes, smp_mb(), rmb, wmb and friends.
