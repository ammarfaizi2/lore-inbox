Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262330AbVAJRnr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262330AbVAJRnr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 12:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262350AbVAJRni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 12:43:38 -0500
Received: from fsmlabs.com ([168.103.115.128]:17885 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S262330AbVAJRXI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 12:23:08 -0500
Date: Mon, 10 Jan 2005 10:23:22 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Roland Dreier <roland@topspin.com>
cc: greg@kroah.com, linux-kernel@vger.kernel.org, tom.l.nguyen@intel.com
Subject: Re: [PATCH] PCI: Clean up printks in msi.c
In-Reply-To: <52sm59yzsx.fsf@topspin.com>
Message-ID: <Pine.LNX.4.61.0501101022500.26637@montezuma.fsmlabs.com>
References: <52sm59yzsx.fsf@topspin.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jan 2005, Roland Dreier wrote:

> Add "PCI:" prefixes and fix up the formatting and grammar of printks
> in drivers/pci/msi.c.  The main motivation was to fix the shouting
> "MSI INIT SUCCESS" message printed when an MSI-using driver is first
> started, but while we're at it we might as well tidy up all the messages.

I reckon just get rid of that MSI init success message entirely.
