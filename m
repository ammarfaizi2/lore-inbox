Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751230AbWDKFE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbWDKFE1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 01:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbWDKFE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 01:04:27 -0400
Received: from ns1.suse.de ([195.135.220.2]:21127 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751230AbWDKFE1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 01:04:27 -0400
From: Andi Kleen <ak@suse.de>
To: "mao, bibo" <bibo.mao@intel.com>
Subject: Re: [PATCH] inline function prefix with __always_inline invsyscall function
Date: Tue, 11 Apr 2006 07:04:21 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <1144725196.9974.10.camel@maobb.site>
In-Reply-To: <1144725196.9974.10.camel@maobb.site>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604110704.21597.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 11 April 2006 05:13, mao, bibo wrote:
> In vsyscall function do_vgettimeofday(), some functions are declared as
> inlined, which is hint for gcc to compile the function inlined but it
> not forced. Sometimes compiler does not compiler the function as
> inlined, So here inline is replaced by __always_inline prefix.
> 
> It does not happen in gcc compiler actually, but it possibly happens.

Applied.

Your patch was word wrapped. I fixed that by hand, but please avoid
it in future submissions.

Thanks,

-Andi
