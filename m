Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272070AbTHDSAX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 14:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272072AbTHDSAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 14:00:23 -0400
Received: from zok.sgi.com ([204.94.215.101]:2771 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S272068AbTHDSAT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 14:00:19 -0400
Date: Mon, 4 Aug 2003 11:00:16 -0700
To: "H. J. Lu" <hjl@lucon.org>
Cc: davidm@hpl.hp.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: milstone reached: ia64 linux builds out of Linus' tree
Message-ID: <20030804180015.GA543@sgi.com>
Mail-Followup-To: "H. J. Lu" <hjl@lucon.org>, davidm@hpl.hp.com,
	linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
References: <200308041737.h74HbdCf015443@napali.hpl.hp.com> <20030804175308.GB16804@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030804175308.GB16804@lucon.org>
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 04, 2003 at 10:53:08AM -0700, H. J. Lu wrote:
> On Mon, Aug 04, 2003 at 10:37:39AM -0700, David Mosberger wrote:
> > As of this morning, Linus's current bk tree
> > (http://linux.bkbits.net:8080/linux-2.5) builds and works out of the
> > box for ia64!
> > 
> 
> Does it work on bigsur? Does it support kernel modules?

I just tried the latest on my big sur, and though I think modules work
(at least they build for other machines), big sur is broken because
non-ACPI based PCI enumeration has been removed from the tree.

Jesse
