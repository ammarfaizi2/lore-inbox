Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbVBNJrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbVBNJrM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 04:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbVBNJrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 04:47:12 -0500
Received: from dou122.neoplus.adsl.tpnet.pl ([83.24.128.122]:52710 "EHLO
	orbiter.attika.ath.cx") by vger.kernel.org with ESMTP
	id S261375AbVBNJrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 04:47:10 -0500
Date: Mon, 14 Feb 2005 10:47:01 +0100
From: Piotr Kaczuba <pepe@attika.ath.cx>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI access mode on x86_64
Message-ID: <20050214094701.GA323@attika.ath.cx>
References: <20050213213117.GA18812@attika.ath.cx> <m1oeenh53g.fsf@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1oeenh53g.fsf@muc.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2005 at 10:18:43AM +0100, Andi Kleen wrote:
> Piotr Kaczuba <pepe@attika.ath.cx> writes:
> > Is there a reason why "PCI access mode" config option isn't available for
> > x86_64? Due to this, PCIE config options aren't available either.
> 
> There is no 64bit PCI BIOS, so access is always direct.
> 
> I assume you mean mmconfig access with "PCIE config options", that is
> a separate config option and available.

I mean the PCIEPORTBUS option which depends on PCI_GOMMCONFIG or
PCI_GOANY. I assume that due to PCI_MMCONFIG / PCI_GOMMCONFIG mismatch
it's not available on x86_64.

Piotr Kaczuba
