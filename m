Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbVHHSKv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbVHHSKv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 14:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbVHHSKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 14:10:51 -0400
Received: from fmr23.intel.com ([143.183.121.15]:471 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S932169AbVHHSKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 14:10:50 -0400
From: Jesse Barnes <jesse.barnes@intel.com>
To: Martin Murray <mmurray@deepthought.org>
Subject: Re: ata_piix hang in 2.6.13-rc5
Date: Mon, 8 Aug 2005 11:10:35 -0700
User-Agent: KMail/1.8
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <200508081020.48945.jesse.barnes@intel.com> <20050808180311.GA5878@deepthought.org>
In-Reply-To: <20050808180311.GA5878@deepthought.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508081110.35919.jesse.barnes@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, August 8, 2005 11:03 am, Martin Murray wrote:
> For what its worth, I'm seeing the same thing on a 2.6.13-rc5 machine
> with sata_nv on an x86_64 machine. I can get around it by using
> noapic. I initially assumed it was some ACPI or IRQ issue, but my box
> hangs at the exact same place, right after announcing the first
> device.
>
> Try booting with noapic.

Thanks a lot, noapic worked.  I guess that means this is a generic IRQ 
routing or setup issue, rather than something SATA specific?

Jesse
