Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030395AbWHICUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030395AbWHICUs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 22:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030424AbWHICUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 22:20:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:52172 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030395AbWHICU0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 22:20:26 -0400
From: Andi Kleen <ak@suse.de>
To: Magnus Damm <magnus@valinux.co.jp>
Subject: Re: [PATCH 06/06] x86_64: mark init_amd() as __cpuinit
Date: Wed, 9 Aug 2006 04:17:47 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <20060809010345.25458.86096.sendpatchset@cherry.local> <20060809010410.25458.59204.sendpatchset@cherry.local>
In-Reply-To: <20060809010410.25458.59204.sendpatchset@cherry.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608090417.47642.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 August 2006 03:03, Magnus Damm wrote:
> x86_64: mark init_amd() as __cpuinit
> 
> The init_amd() function is only called from identify_cpu() which is already
> marked as __cpuinit. So let's mark it as __cpuinit.

I added all 6 patches. Thanks.
-Andi
