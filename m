Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbWCZR7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWCZR7r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 12:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWCZR7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 12:59:47 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:64232 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750741AbWCZR7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 12:59:46 -0500
Subject: Re: why no option for 'ide=nocddma'?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jack Howarth <howarth@bromo.msbb.uc.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060324184338.7A87511003E@bromo.msbb.uc.edu>
References: <20060324184338.7A87511003E@bromo.msbb.uc.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 26 Mar 2006 19:07:16 +0100
Message-Id: <1143396437.2540.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2006-03-24 at 13:43 -0500, Jack Howarth wrote:
> release unless users pass the 'ide=nodma' kernel option. If
> the problem with CDs using dma isn't going to be fully resolved,
> why can't we have a 'ide=nocddma' kernel option that would only

It is nothing to do with DMA. See the postings in 2004 on the subject.
EOF handling in the block layer and IDE layer don't work for the case
where the size of a block device is not precisely defined

None fo the current block layer maintainers care about fixing it and
nobody else has submitted changes. Feel free to do that.

Fortunately the drivers/ide layer will hopefully be going away soon

Alan

