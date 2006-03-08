Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932246AbWCHJk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbWCHJk5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 04:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932535AbWCHJk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 04:40:57 -0500
Received: from cantor2.suse.de ([195.135.220.15]:26584 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932246AbWCHJk4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 04:40:56 -0500
From: Andi Kleen <ak@suse.de>
To: Zou Nan hai <nanhai.zou@intel.com>
Subject: Re: [Patch] Move swiotlb_init early on X86_64
Date: Wed, 8 Mar 2006 10:33:59 +0100
User-Agent: KMail/1.8
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
References: <1141175458.2642.78.camel@linux-znh> <200603070939.03368.ak@suse.de> <1141773788.2537.27.camel@linux-znh>
In-Reply-To: <1141773788.2537.27.camel@linux-znh>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603081033.59435.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 March 2006 00:23, Zou Nan hai wrote:

>
> , round_down(limit - memmapsize, PAGE_SIZE), limit);?

Indeed. Thanks for catching that.

-Andi
