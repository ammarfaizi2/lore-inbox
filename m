Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262827AbUAGX2z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 18:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262838AbUAGX2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 18:28:55 -0500
Received: from mail.kroah.org ([65.200.24.183]:43734 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262827AbUAGX2w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 18:28:52 -0500
Date: Wed, 7 Jan 2004 15:27:54 -0800
From: Greg KH <greg@kroah.com>
To: Jesse Barnes <jbarnes@sgi.com>
Cc: Grant Grundler <grundler@parisc-linux.org>,
       Matthew Wilcox <willy@debian.org>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, jeremy@sgi.com
Subject: Re: [RFC] Relaxed PIO read vs. DMA write ordering
Message-ID: <20040107232754.GA2807@kroah.com>
References: <20040107175801.GA4642@sgi.com> <20040107190206.GK17182@parcelfarce.linux.theplanet.co.uk> <20040107222142.GB14951@colo.lackof.org> <20040107230712.GB6837@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040107230712.GB6837@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 07, 2004 at 03:07:12PM -0800, Jesse Barnes wrote:
> 
>   1) add pcix_enable_relaxed() and read_relaxed() (read() would always be
>      ordered)

This probably preserves the current situation best, enabling driver
writers to be explicit in knowing what is happening.

thanks,

greg k-h
