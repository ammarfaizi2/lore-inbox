Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264226AbTGKQig (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 12:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264231AbTGKQig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 12:38:36 -0400
Received: from storm.he.net ([64.71.150.66]:12010 "HELO storm.he.net")
	by vger.kernel.org with SMTP id S264226AbTGKQia (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 12:38:30 -0400
Date: Fri, 11 Jul 2003 09:53:12 -0700
From: Greg KH <greg@kroah.com>
To: "Sy, Dely L" <dely.l.sy@intel.com>
Cc: "Zink, Dan" <dan.zink@hp.com>, linux-kernel@vger.kernel.org,
       pcihpd-discuss@lists.sourceforge.net,
       "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [Pcihpd-discuss] Re: PCI Hot-plug driver patch for 2.5.74 kernel
Message-ID: <20030711165312.GA22044@kroah.com>
References: <42050DF556283A4D977B111EB706320810026E@orsmsx407.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42050DF556283A4D977B111EB706320810026E@orsmsx407.jf.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 11, 2003 at 09:10:03AM -0700, Sy, Dely L wrote:
> > Would it be possible to split this into smaller patches that
> > each do one particular thing?
> 
> This patch has moved the code around quite a bit to separate out the 
> resource gathering code to support both HRT & ACPI, and to put the 
> code that is specific to the Compaq HPC HW programming model in 
> cpqphp_hpc.c.  If you feel there is a need to split the patch into 
> smaller ones, we can further discuss on that.

Yes, I would feel better if you do that.  This patch is just way to big,
and it's hard to see the changes that you have made.  If you can split
it up into a sequence of patches that change one major thing at a time,
I would really appreciate it.

thanks,

greg k-h
