Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751184AbWGPTZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbWGPTZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 15:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbWGPTZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 15:25:28 -0400
Received: from gate.crashing.org ([63.228.1.57]:62111 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751184AbWGPTZ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 15:25:28 -0400
Subject: Re: Rescan IDE interface when no IDE devices are present
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Daniel De Graaf <danieldegraaf@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <427c54c0607161212m714f4faew60b8615e06ac885a@mail.gmail.com>
References: <427c54c0607161212m714f4faew60b8615e06ac885a@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 16 Jul 2006 15:25:02 -0400
Message-Id: <1153077903.5905.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-07-16 at 14:12 -0500, Daniel De Graaf wrote:
> My laptop has only one IDE interface (/dev/hdc), which means there are
> no valid IDE block devices which can be used for HDIO_SCAN_HWIF ioctl
> to scan for the insertion of my CD-ROM drive.
> 
> Are there alternate methods of invoking this ioctl, or for creating an
> open filehandle where it can be used?

If you have ide1, you have both hdc and hdd (slave of hdc) unles sit's
not really IDE ...

Ben.


