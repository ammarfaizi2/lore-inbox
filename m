Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265950AbUFYAYm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265950AbUFYAYm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 20:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265959AbUFYAYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 20:24:42 -0400
Received: from havoc.gtf.org ([216.162.42.101]:9912 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S265950AbUFYAYl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 20:24:41 -0400
Date: Thu, 24 Jun 2004 20:24:25 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Chew <achew@nvidia.com>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.27-rc1, nvaudio, i810_audio
Message-ID: <20040625002425.GC19939@havoc.gtf.org>
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF043984F7@mail-sc-6-bk.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DCB9B7AA2CAB7F418919D7B59EE45BAF043984F7@mail-sc-6-bk.nvidia.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 04:44:59PM -0700, Andrew Chew wrote:
> This patch adds a new driver under linux/drivers/sound/nvaudio.  The new
> driver is heavily derived from the i810_audio driver, but includes a lot
> of new work in adding multichannel and spdif support.
> 
> The patch removes the following PCI device IDs from the i810_audio
> driver:

also, if you're gonna do a driver for the newer ich-ish audio,
it's a good time to make the driver MMIO-only...

	Jeff



