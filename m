Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263042AbVAFVgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263042AbVAFVgc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 16:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263039AbVAFVeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 16:34:06 -0500
Received: from hqemgate01.nvidia.com ([216.228.112.170]:50985 "EHLO
	HQEMGATE01.nvidia.com") by vger.kernel.org with ESMTP
	id S263033AbVAFVcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 16:32:31 -0500
Date: Thu, 6 Jan 2005 15:32:25 -0600
From: Terence Ripperda <tripperda@nvidia.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: tripperda@nvidia.com
Subject: inter_module_get and __symbol_get
Message-ID: <20050106213225.GJ6184@hygelac>
Reply-To: Terence Ripperda <tripperda@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Accept-Language: en
X-Operating-System: Linux hrothgar 2.6.7
X-OriginalArrivalTime: 06 Jan 2005 21:32:26.0553 (UTC) FILETIME=[378C3290:01C4F437]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

we've noticed that in recent 2.6.10 kernels that the inter_module_
routines (such as inter_module_get) are marked deprecated. it appears
that the __symbol_ routines (such as __symbol_get) are intended as the
replacement routines.

unfortunately, __symbol_get is only exported as a GPL symbol (I see a
reference to a _gpl verion in module.h, but no definition). is this
intentional? will there be a non-gpled version of an equivalent
routine?

Thanks,
Terence


