Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267648AbTB1IqW>; Fri, 28 Feb 2003 03:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267656AbTB1IqV>; Fri, 28 Feb 2003 03:46:21 -0500
Received: from ns.suse.de ([213.95.15.193]:7954 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S267648AbTB1IqV>;
	Fri, 28 Feb 2003 03:46:21 -0500
To: Matthew Wilcox <willy@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Proposal: Eliminate GFP_DMA
References: <20030228064631.G23865@parcelfarce.linux.theplanet.co.uk.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 28 Feb 2003 09:56:41 +0100
In-Reply-To: Matthew Wilcox's message of "28 Feb 2003 07:48:41 +0100"
Message-ID: <p73heao7ph2.fsf@amdsimf.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@debian.org> writes:
> -
> +#define GFP_ATOMIC_DMA (GFP_ATOMIC | __GFP_DMA)
> +#define GFP_KERNEL_DMA (GFP_KERNEL | __GFP_DMA)
> 
> combined with changing some users to use __GFP_DMA if they really do mean
> the bitmask.  Comments?

Sounds like a good 2.7.x early project. Currently we still have too much
driver breakage for the next release to break even more right now.

-Andi
