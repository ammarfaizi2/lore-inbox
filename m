Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264307AbUHGUWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264307AbUHGUWG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 16:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264346AbUHGUWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 16:22:06 -0400
Received: from colin2.muc.de ([193.149.48.15]:39184 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S264307AbUHGUWB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 16:22:01 -0400
Date: 7 Aug 2004 22:22:00 +0200
Date: Sat, 7 Aug 2004 22:22:00 +0200
From: Andi Kleen <ak@muc.de>
To: Alexander Nyberg <alexn@telia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: x86_64 crashes in 2.6.8-rc3-mm1
Message-ID: <20040807202200.GA16382@muc.de>
References: <1091892859.1664.11.camel@boxen.(null)>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091892859.1664.11.camel@boxen.(null)>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 07, 2004 at 05:34:19PM +0200, Alexander Nyberg wrote:
> Hi
> 
> Have had a bit of an issue here getting before mentioned kernel to boot without 
> using the CONFIG_GART_IOMMU
> 
> What appears to happen is that the amd74xx driver eats all
> memory. 2.6.8-rc3 plus the patches at the bottom applied from the x86_64 patchkit.

Known issue. It's already fixed in x86_64-2.6.8rc3-1, but -mm still
uses the older code base.

Workaround is to not turn off this option.

-Andi
