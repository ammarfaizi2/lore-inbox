Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262510AbVBCOpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262510AbVBCOpo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 09:45:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263321AbVBCOkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 09:40:24 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:51726 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S263184AbVBCO3u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 09:29:50 -0500
Date: Thu, 3 Feb 2005 15:29:43 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: linux-os <linux-os@analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Joe User DOS kills Linux-2.6.10
Message-ID: <20050203142943.GB5680@pclin040.win.tue.nl>
References: <Pine.LNX.4.61.0502021314340.5410@chaos.analogic.com> <20050203003334.GA5680@pclin040.win.tue.nl> <Pine.LNX.4.61.0502030725480.8811@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0502030725480.8811@chaos.analogic.com>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2005 at 07:28:50AM -0500, linux-os wrote:

> I ran badblocks (all night). There were none. It's a SCSI disk
> and it requires chunks of DMA RAM for each write. The machine
> just croaks when it gets low on RAM and tries to write to
> SCSI swap which requires RAM.

In some other post you said that you were writing past the
end of the partition or disk.

If the disk is fine and you have reproducible errors
then the first thing to check is whether your partition table
is correct, whether your swap signature is correct, whether
the total size of the disk is recognized correctly at boot time.
