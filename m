Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751617AbWBQUE7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751617AbWBQUE7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 15:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751644AbWBQUE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 15:04:58 -0500
Received: from palrel10.hp.com ([156.153.255.245]:65493 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S1751616AbWBQUE4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 15:04:56 -0500
Date: Fri, 17 Feb 2006 12:04:54 -0800
From: Grant Grundler <iod00d@hp.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Chris Wedgwood <cw@f00f.org>, Grant Grundler <grundler@parisc-linux.org>,
       Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, linux-ia64@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz,
       "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>,
       Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: Problems with MSI-X on ia64
Message-ID: <20060217200454.GA24942@esmail.cup.hp.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F05BF610F@scsmsx401.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F05BF610F@scsmsx401.amr.corp.intel.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2006 at 11:52:45AM -0800, Luck, Tony wrote:
> > Hrm, it may be doing this.  I wonder how that works though with 4GB's
> > of RAM installed?
> 
> Systems with 4G of RAM usually map part of the RAM above 4G so as to
> leave a hole for i/o mapping etc.

exactly.
rx2600 physical memory map only has 1GB of RAM below 4GB address space.

grant
