Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271596AbTGRMnP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 08:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271699AbTGRMnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 08:43:15 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:7891
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S271596AbTGRMnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 08:43:15 -0400
Subject: Re: DRM, radeon, and X 4.3
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: "Andrew S. Johnson" <andy@asjohnson.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030717172625.GA16502@suse.de>
References: <200307170539.25702.andy@asjohnson.com>
	 <20030717172625.GA16502@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058532934.19558.31.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 18 Jul 2003 13:55:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-07-17 at 18:26, Dave Jones wrote:
>  > Linux agpgart interface v0.100 (c) Dave Jones
>  > [drm] Initialized radeon 1.9.0 20020828 on minor 0
>  > [drm:radeon_cp_init] *ERROR* radeon_cp_init called without lock held
>  > [drm:radeon_unlock] *ERROR* Process 1929 using kernel context 0
>  > 
>  > There is something X doesn't like.  How do I fix this?
> 
> Looks like there isn't an agp chipset module also loaded
> (via-agp.o, intel-agp.o etc...)

Still shouldnt do that - also the radeon doesn't require AGP

