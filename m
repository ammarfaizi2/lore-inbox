Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751326AbWHCUn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbWHCUn6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 16:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbWHCUn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 16:43:58 -0400
Received: from mail.renesas.com ([202.234.163.13]:56541 "EHLO
	mail02.idc.renesas.com") by vger.kernel.org with ESMTP
	id S1751326AbWHCUn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 16:43:57 -0400
Date: Fri, 04 Aug 2006 05:43:47 +0900
From: Paul Mundt <paul.mundt@renesas.com>
Subject: Re: [linuxsh-dev] [PATCH] sh: fix proc file removal for	superh	store
 queue module
In-reply-to: <20060803201857.GC5004@localhost.localdomain>
To: Neil Horman <nhorman@tuxdriver.com>
Cc: Andrew Morton <akpm@osdl.org>, kernel-janitors@lists.osdl.org,
       lethal@linux-sh.org, kkojima@rr.iij4u.or.jp,
       linuxsh-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org
Message-id: <1154637827.8280.0.camel@localhost>
Organization: Renesas Technology America, Inc.
MIME-version: 1.0
X-Mailer: Evolution 2.6.2
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <20060803191828.GA5004@localhost.localdomain>
 <20060803124235.67bb664b.akpm@osdl.org>
 <20060803201857.GC5004@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-03 at 16:18 -0400, Neil Horman wrote:
> Patch to clean up proc file removal in sq module for superh arch.  currently on
> a failed module load or on module unload a proc file is left registered which
> can cause a random memory execution or oopses if read after unload.  This patch
> cleans up that deregistration.
> 
Looks good, thanks Neil.

Acked-by: Paul Mundt <paul.mundt@renesas.com>
