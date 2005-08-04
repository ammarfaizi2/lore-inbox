Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262475AbVHDKyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262475AbVHDKyb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 06:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262472AbVHDKya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 06:54:30 -0400
Received: from colin.muc.de ([193.149.48.1]:32779 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S262479AbVHDKy0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 06:54:26 -0400
Date: 4 Aug 2005 12:54:24 +0200
Date: Thu, 4 Aug 2005 12:54:24 +0200
From: Andi Kleen <ak@muc.de>
To: Ashok Raj <ashok.raj@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, zwane@arm.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 8/8] x86_64: Choose physflat for AMD systems only when >8 CPUS.
Message-ID: <20050804105424.GE97893@muc.de>
References: <20050801202017.043754000@araj-em64t> <20050801203011.746098000@araj-em64t>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050801203011.746098000@araj-em64t>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2005 at 01:20:25PM -0700, Ashok Raj wrote:
> It is not required to choose the physflat mode when CPU hotplug is enabled 
> and CPUs <=8 case. Use of genapic_flat with the mask version is capable of 
> doing the same, instead of doing the send_IPI_mask_sequence() where its a 
> unicast.
> 
> This is another change that Andi introduced with the physflat mode. 
> 
> Andi: Do you think this is acceptable?

Yes it's ok.

-Andi
