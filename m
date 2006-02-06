Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932329AbWBFTrj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbWBFTrj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 14:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932330AbWBFTre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 14:47:34 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:31973 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932329AbWBFTrc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 14:47:32 -0500
Subject: Re: DMA in PCI chipset -- module vs. compiled-in
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lee Revell <rlrevell@joe-job.com>
Cc: William Park <opengeometry@yahoo.ca>, linux-kernel@vger.kernel.org
In-Reply-To: <1139200372.2791.208.camel@mindpipe>
References: <20060206034312.GA2962@node1.opengeometry.net>
	 <1139200372.2791.208.camel@mindpipe>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 06 Feb 2006 19:49:25 +0000
Message-Id: <1139255365.10437.49.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2006-02-05 at 23:32 -0500, Lee Revell wrote:
> Generic and chipset specific support are not complementary, they are
> mutually exclusive.  Having generic PCI IDE support enabled will prevent
> the chipset specific support from working properly.

Untrue.

The PCI generic driver by default grabs only hardware with PCI IDS it
knows can be driven generically. That list purposefully has no overlaps
with chipset drivers.

Alan

