Return-Path: <linux-kernel-owner+w=401wt.eu-S1750734AbWLNOBw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWLNOBw (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 09:01:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbWLNOBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 09:01:52 -0500
Received: from brick.kernel.dk ([62.242.22.158]:2052 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750734AbWLNOBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 09:01:52 -0500
Date: Thu, 14 Dec 2006 15:03:16 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Joerg Schilling <Joerg.Schilling@fokus.fraunhofer.de>
Cc: linux-kernel@vger.kernel.org, teunis@alphatrade.com
Subject: Re: 2.6.19 kernel series, SATA, wodim (cd recording), synaptics  update,
Message-ID: <20061214140315.GB5010@kernel.dk>
References: <4581559d.iqe9L1/wj2D5j93L%Joerg.Schilling@fokus.fraunhofer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4581559d.iqe9L1/wj2D5j93L%Joerg.Schilling@fokus.fraunhofer.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14 2006, Joerg Schilling wrote:
> >CD recording : recorder no longer detected by "wodim" software set in
> >2.6.19.   I suspect it's a bug in the software...  but don't know where
> >to look for changes.   2.6.19-rc5 worked.
> >hardware: IDE MATSHITADVD-RAM UJ-820S
> >(2.6.19-git6 also fails with external LiteON USB DVD burner)

It was an intermittent unlucky bug between 2.6.19 and 2.6.20-rc1, it got
fixed the other day. Update your kernel, and it'll work again.

> Do not use cdrecord derivates but the original as derivates may have bugs
> that are not present in the original.

And vice versa :-)

-- 
Jens Axboe

