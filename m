Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932078AbVHXUKH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbVHXUKH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 16:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbVHXUKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 16:10:06 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:50625 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S932078AbVHXUKF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 16:10:05 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Kumar Gala <galak@freescale.com>
Subject: Re: [PATCH 05/15] ia64: remove use of asm/segment.h
Date: Wed, 24 Aug 2005 14:09:55 -0600
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       tony.luck@intel.com, linux-ia64@vger.kernel.org
References: <Pine.LNX.4.61.0508241139100.23956@nylon.am.freescale.net> <Pine.LNX.4.61.0508241152380.23956@nylon.am.freescale.net>
In-Reply-To: <Pine.LNX.4.61.0508241152380.23956@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508241409.55570.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 24 August 2005 10:53 am, Kumar Gala wrote:
> Removed IA64 architecture specific users of asm/segment.h and
> asm-ia64/segment.h itself

I posted a similar patch a month ago, but I only removed the
arch/ia64 includes of asm/segment.h.

There are still a few drivers that include asm/segment.h, so
I don't think we should remove asm/segment.h itself just yet.
