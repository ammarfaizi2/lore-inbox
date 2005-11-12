Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932278AbVKLJds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbVKLJds (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 04:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbVKLJds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 04:33:48 -0500
Received: from verein.lst.de ([213.95.11.210]:20632 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S932278AbVKLJdr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 04:33:47 -0500
Date: Sat, 12 Nov 2005 10:33:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org, schwidefsky@de.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] add compat_ioctl methods to dasd
Message-ID: <20051112093340.GA15702@lst.de>
References: <20051104221652.GB9384@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051104221652.GB9384@lst.de>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2005 at 11:16:52PM +0100, Christoph Hellwig wrote:
> all dasd ioctls are directly useable from 32bit process, thus switch
> the dasd driver to unlocked_ioctl/compat_ioctl and get rid of the
> translations in the global table.

ping on all the four s390 compat_ioctl patches.  These are few of the
remaining arch compat_ioctl bits and I'd really really like to get rid
of them soonish.

