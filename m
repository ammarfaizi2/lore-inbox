Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030426AbWHICpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030426AbWHICpX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 22:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030432AbWHICpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 22:45:22 -0400
Received: from ns2.suse.de ([195.135.220.15]:37327 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030426AbWHICpW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 22:45:22 -0400
From: Andi Kleen <ak@suse.de>
To: john stultz <johnstul@us.ibm.com>
Subject: Re: [RFC][PATCH 2/6] x86_64: hpet_address cleanup
Date: Wed, 9 Aug 2006 04:31:13 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20060809021707.23103.5607.sendpatchset@cog.beaverton.ibm.com> <20060809021720.23103.26378.sendpatchset@cog.beaverton.ibm.com>
In-Reply-To: <20060809021720.23103.26378.sendpatchset@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608090431.13309.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 August 2006 04:17, john stultz wrote:
> In preparation for supporting generic timekeeping, this patch cleans up 
> x86-64's use of vxtime.hpet_address, changing it to just hpet_address 
> as is also used in i386. This is necessary since the vxtime structure 
> will be going away.

Does the kernel still boot with that patch only? 
Your new variable doesn't seem to be exported to vsyscalls

-Andi
