Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261337AbUKNV1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbUKNV1v (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 16:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbUKNV1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 16:27:50 -0500
Received: from cantor.suse.de ([195.135.220.2]:54938 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261337AbUKNV1u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 16:27:50 -0500
Date: Sun, 14 Nov 2004 22:05:32 +0100
From: Andi Kleen <ak@suse.de>
To: Alexander Nyberg <alexn@dsv.su.se>
Cc: torvalds@osdl.org, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86_64: assign_irq_vector should not be marked __init
Message-ID: <20041114210532.GA7913@wotan.suse.de>
References: <1100438810.717.12.camel@boxen>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1100438810.717.12.camel@boxen>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 14, 2004 at 02:26:50PM +0100, Alexander Nyberg wrote:
> Hej Linus
> 
> This box crashed at startup today and I noticed that some modules will 
> need to have assign_irq_vector() available although it is marked as __init. 
> Looks like it was done for i386 in but not x86_64...

Thanks added to my tree.

-Andi
