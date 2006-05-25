Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030304AbWEYSBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030304AbWEYSBv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 14:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030302AbWEYSBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 14:01:50 -0400
Received: from lixom.net ([66.141.50.11]:21418 "EHLO mail.lixom.net")
	by vger.kernel.org with ESMTP id S1030300AbWEYSBu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 14:01:50 -0400
Date: Thu, 25 May 2006 11:00:57 -0700
To: Chris Leech <christopher.leech@intel.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 2/9] [I/OAT] Driver for the Intel(R) I/OAT DMA engine
Message-ID: <20060525180057.GC9867@pb15.lixom.net>
References: <20060524001653.19403.31396.stgit@gitlost.site> <20060524002013.19403.57410.stgit@gitlost.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060524002013.19403.57410.stgit@gitlost.site>
User-Agent: Mutt/1.5.11
From: Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Minor nitpick below:


On Tue, May 23, 2006 at 05:20:13PM -0700, Chris Leech wrote:

> +static int enumerate_dma_channels(struct ioat_device *device)

[...]

> +	enumerate_dma_channels(device);

Return value is never used, might as well change the function
declaration to void.


-Olof
