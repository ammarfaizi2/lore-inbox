Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932445AbWEWWG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445AbWEWWG5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 18:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932456AbWEWWG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 18:06:57 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:15630 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S932445AbWEWWG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 18:06:56 -0400
Date: Wed, 24 May 2006 02:06:54 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Patrick Jefferson <patrick.jefferson@hp.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH] PCI: fix MMIO addressing collisions
Message-ID: <20060524020654.A19699@jurassic.park.msu.ru>
References: <4472FFDA.2040005@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <4472FFDA.2040005@hp.com>; from patrick.jefferson@hp.com on Tue, May 23, 2006 at 12:28:10PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2006 at 12:28:10PM +0000, Patrick Jefferson wrote:
> Clearing PCI Command bits fixes machine halts observed during sizing 
> seqences using MMIO cycles. Clearing the bits is suggested by an 
> implementation note in the PCI spec.

The patch is not acceptable. This was discussed back in 2002:

  http://www.uwsg.iu.edu/hypermail/linux/kernel/0212.2/index.html#978

Ivan.
