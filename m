Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264749AbUD2UqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264749AbUD2UqL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 16:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264972AbUD2UkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 16:40:06 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:15119 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264978AbUD2Uht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 16:37:49 -0400
Date: Thu, 29 Apr 2004 21:37:47 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Markus Lidel <Markus.Lidel@shadowconnect.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] I2O subsystem fixing and cleanup for 2.6
Message-ID: <20040429213747.A3701@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Markus Lidel <Markus.Lidel@shadowconnect.com>,
	linux-kernel@vger.kernel.org
References: <40916612.4070206@shadowconnect.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <40916612.4070206@shadowconnect.com>; from Markus.Lidel@shadowconnect.com on Thu, Apr 29, 2004 at 10:31:14PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2004 at 10:31:14PM +0200, Markus Lidel wrote:
> - i2o_block-cleanup.patch
>    * more than 3 "visible" disks (hda, hdb, hdc, hdd) lead to kernel
>      panics.
>    * removes some unused code with partitions.
>    * I2O_LOCK was often called with the addresses of the controller, and
>      not with the address of the device. Fixed.

Sounds like a good reason to completly kill the macro while we're at it.

