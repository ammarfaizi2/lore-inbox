Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264135AbTEGWhZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 18:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264137AbTEGWhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 18:37:25 -0400
Received: from [66.212.224.118] ([66.212.224.118]:57614 "HELO
	hemi.commfireservices.com") by vger.kernel.org with SMTP
	id S264135AbTEGWhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 18:37:24 -0400
Date: Wed, 7 May 2003 18:41:13 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Mark Haverkamp <markh@osdl.org>
Cc: Jens Axboe <axboe@suse.de>, Mark Wong <markw@osdl.org>,
       "" <akpm@digeo.com>, linux-kernel <linux-kernel@vger.kernel.org>,
       "" <wli@holomorphy.com>
Subject: Re: OSDL DBT-2 AS vs. Deadline 2.5.68-mm2
In-Reply-To: <1052329151.25135.14.camel@markh1.pdx.osdl.net>
Message-ID: <Pine.LNX.4.50.0305071833570.2157-100000@montezuma.mastecende.com>
References: <20030507164728.GO823@suse.de>  <200305071659.h47GxmW22250@mail.osdl.org>
  <20030507173637.GQ823@suse.de> <1052329151.25135.14.camel@markh1.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 May 2003, Mark Haverkamp wrote:

> That is what I thought, but I wanted to get a machine with lots of
> memory to try it out on.

if(aac->pae_support)
	pci_set_dma_mask(dev, 0xFFFFFFFFFFFFFFFFUL);

This probably wants 0xFFFFFFFFFFFFFFFFULL and checking pci_set_dma_mask() 
return value.

-- 
function.linuxpower.ca
