Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265396AbTFWWHt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 18:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265410AbTFWWHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 18:07:49 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:18311 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265396AbTFWWGg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 18:06:36 -0400
Date: Mon, 23 Jun 2003 15:19:14 -0700
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5 patch] fix buggy comparison in cpqphp_pci.c
Message-ID: <20030623221914.GB11244@kroah.com>
References: <20030621142153.GU29247@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030621142153.GU29247@fs.tum.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 21, 2003 at 04:21:53PM +0200, Adrian Bunk wrote:
> Hi Greg,
> 
> I don't understand the code good enough to be sure my patch is correct, 
> but the current code is definitely buggy:
> 
> 0xFF is the maximum value for an u8, so tdevice < 0x100 is _always_ 
> true.

Nice catch, I've applied this.

thanks,

greg k-h
