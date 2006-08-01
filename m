Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751703AbWHAR0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751703AbWHAR0i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 13:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751694AbWHAR0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 13:26:06 -0400
Received: from ns.suse.de ([195.135.220.2]:62615 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751696AbWHAR0E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 13:26:04 -0400
From: Andi Kleen <ak@suse.de>
To: Muli Ben-Yehuda <muli@il.ibm.com>
Subject: Re: [PATCH x86-64]: remove superflous BUG_ON's in nommu and gart
Date: Tue, 1 Aug 2006 19:06:50 +0200
User-Agent: KMail/1.9.3
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>,
       "discuss@x86-64.org" <discuss@x86-64.org>
References: <20060801125932.GF3436@rhun.haifa.ibm.com>
In-Reply-To: <20060801125932.GF3436@rhun.haifa.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608011906.50118.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 August 2006 14:59, Muli Ben-Yehuda wrote:
> There's no need to check for invalid DMA data direction in nommu and
> gart since we do it in dma-mapping.h anyway before calling the
> individual dma-ops.

Applied thanks

-Andi
