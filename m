Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261700AbVC3BLo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261700AbVC3BLo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 20:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261701AbVC3BLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 20:11:44 -0500
Received: from embeddededge.com ([209.113.146.155]:18437 "EHLO
	penguin.netx4.com") by vger.kernel.org with ESMTP id S261700AbVC3BLn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 20:11:43 -0500
In-Reply-To: <Pine.LNX.4.61.0503291627130.16284@blarg.somerset.sps.mot.com>
References: <20050329201209.GB30850@gate.ebshome.net> <Pine.LNX.4.61.0503291627130.16284@blarg.somerset.sps.mot.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <84ab51297f043a761321ee6eddc43d4a@embeddededge.com>
Content-Transfer-Encoding: 7bit
Cc: shall@mvista.com, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       linuxppc-embedded <linuxppc-embedded@ozlabs.org>
From: Dan Malek <dan@embeddededge.com>
Subject: Re: [PATCH] ppc32: CPM2 PIC cleanup irq_to_siubit array
Date: Tue, 29 Mar 2005 20:10:57 -0500
To: Kumar Gala <galak@freescale.com>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mar 29, 2005, at 5:30 PM, Kumar Gala wrote:

> Cleaned up irq_to_siubit array so we no longer need to do 1 << 
> (31-bit),
> just 1 << bit.

Will you please put a comment in here that indicates this array now
has this computation done?  When I wrote it, these bit numbers
matched the registers and the documentation, so I didn't take
the time to explain. :-)

Thanks.


	-- Dan

