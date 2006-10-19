Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946577AbWJSWU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946577AbWJSWU1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 18:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946583AbWJSWU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 18:20:26 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:18447 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1946577AbWJSWUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 18:20:23 -0400
Date: Thu, 19 Oct 2006 23:20:14 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: David KOENIG <karhudever@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pci_[g|s]et_drvdata() versus ->driver_data
Message-ID: <20061019222014.GB10922@flint.arm.linux.org.uk>
Mail-Followup-To: David KOENIG <karhudever@gmail.com>,
	linux-kernel@vger.kernel.org
References: <4537C4CC.7020902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4537C4CC.7020902@gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2006 at 11:32:44AM -0700, David KOENIG wrote:
> Is there any reason for some drivers that I should leave references as
> foo->driver_data instead of pci_get_drvdata(foo)?

When "foo" is not a struct pci_dev ?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
