Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264300AbUAHKCC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 05:02:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264303AbUAHKCC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 05:02:02 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:39821 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S264300AbUAHKCA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 05:02:00 -0500
To: Greg KH <greg@kroah.com>
Cc: Jesse Barnes <jbarnes@sgi.com>, Grant Grundler <grundler@parisc-linux.org>,
       Matthew Wilcox <willy@debian.org>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, jeremy@sgi.com
Subject: Re: [RFC] Relaxed PIO read vs. DMA write ordering
References: <20040107175801.GA4642@sgi.com>
	<20040107190206.GK17182@parcelfarce.linux.theplanet.co.uk>
	<20040107222142.GB14951@colo.lackof.org>
	<20040107230712.GB6837@sgi.com> <20040107232754.GA2807@kroah.com>
From: Jes Sorensen <jes@wildopensource.com>
Date: 08 Jan 2004 05:01:05 -0500
In-Reply-To: <20040107232754.GA2807@kroah.com>
Message-ID: <yq0oeteiwta.fsf@wildopensource.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Greg" == Greg KH <greg@kroah.com> writes:

Greg> On Wed, Jan 07, 2004 at 03:07:12PM -0800, Jesse Barnes wrote:
>>  1) add pcix_enable_relaxed() and read_relaxed() (read() would
>> always be ordered)

Greg> This probably preserves the current situation best, enabling
Greg> driver writers to be explicit in knowing what is happening.

I concur, it also matches the current convention we have with
__raw_readX()

Cheers,
Jes
