Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751798AbWIRTVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbWIRTVk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 15:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751795AbWIRTVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 15:21:40 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:22415 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1751783AbWIRTVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 15:21:39 -0400
Date: Mon, 18 Sep 2006 13:21:38 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Konrad Rzeszutek <konradr@redhat.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       alexisb@us.ibm.com
Subject: Re: [PATCH] aic94xx: Compile problem on s390
Message-ID: <20060918192138.GR2585@parisc-linux.org>
References: <20060918191545.GA10525@krzeszut.users.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060918191545.GA10525@krzeszut.users.redhat.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2006 at 03:15:45PM -0400, Konrad Rzeszutek wrote:
> The aic94xx driver in my-scsi and aic94xx James Bottomley tree does not
> compile on s390. Since the driver is generic, it makes sense to fix.

Erm, well, I don't think there's any s390s with PCI ;-)

> The patch is quite simple:
> +#include <asm/scatterlist.h>

Surely should be linux/scatterlist.h?
