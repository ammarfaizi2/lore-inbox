Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267810AbUH2Ncn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267810AbUH2Ncn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 09:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267815AbUH2Ncn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 09:32:43 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:42176 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S267810AbUH2Nck
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 09:32:40 -0400
Date: Sun, 29 Aug 2004 15:14:38 +0200
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: Martin Schlemmer <azarah@nosferatu.za.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Greg KH <greg@kroah.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [UPDATED PATCH 1/2] export module parameters in sysfs for modules _and_ built-in code
Message-ID: <20040829131438.GF17032@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.de>,
	Martin Schlemmer <azarah@nosferatu.za.org>,
	Rusty Russell <rusty@rustcorp.com.au>, Greg KH <greg@kroah.com>,
	lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040801165407.GA8667@dominikbrodowski.de> <1091426395.430.13.camel@bach> <20040802214710.GB7772@dominikbrodowski.de> <1092858948.8998.47.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092858948.8998.47.camel@nosferatu.lan>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2004 at 09:55:49PM +0200, Martin Schlemmer wrote:
> On Mon, 2004-08-02 at 23:47, Dominik Brodowski wrote:
> 
> I know its tainted (nvidia), but this is difficult to test,
> as it usually only happens if the box have been up for a while
> and I modprobe something (ext2 in most of the cases).

Sorry for the delay, was on vacations... Which variant of the patch were you
using? Did it already shuffle the section of kernel_param around? If not,
that's the cause -- and that patch has reached Linus' tree by now.

Thanks for testing,
	Dominik
