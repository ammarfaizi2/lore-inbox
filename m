Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269105AbUINCBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269105AbUINCBr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 22:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269104AbUINCBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 22:01:47 -0400
Received: from are.twiddle.net ([64.81.246.98]:59777 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S269105AbUINCBj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 22:01:39 -0400
Date: Mon, 13 Sep 2004 19:01:16 -0700
From: Richard Henderson <rth@twiddle.net>
To: Hanna Linder <hannal@us.ibm.com>
Cc: ink@jurassic.park.msu.ru, linux-kernel@vger.kernel.org, greg@kroah.com,
       wli@holomorphy.com
Subject: Re: [RFT 2.6.9-rc1 alpha sys_alcor.c] [1/2] convert pci_find_device to pci_get_device
Message-ID: <20040914020116.GA23058@twiddle.net>
Mail-Followup-To: Hanna Linder <hannal@us.ibm.com>,
	ink@jurassic.park.msu.ru, linux-kernel@vger.kernel.org,
	greg@kroah.com, wli@holomorphy.com
References: <806400000.1095118633@w-hlinder.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <806400000.1095118633@w-hlinder.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2004 at 04:37:13PM -0700, Hanna Linder wrote:
> Here is a very simple patch to convert pci_find_device call to pci_get_device.
> As I don't have an alpha box or cross compiler could someone (wli- wink wink)
> please verify it compiles and doesn't break anything, thanks a lot.

Presumably the intent is to eventually remove pci_find_device?
These routines run at the very beginning of bootup; there cannot
possibly be any races.


r~
