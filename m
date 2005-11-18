Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbVKRAZX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbVKRAZX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 19:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbVKRAZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 19:25:23 -0500
Received: from fmr22.intel.com ([143.183.121.14]:62110 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1750725AbVKRAZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 19:25:23 -0500
Date: Thu, 17 Nov 2005 16:24:51 -0800
From: Rajesh Shah <rajesh.shah@intel.com>
To: Niklas Kallman <kjarvel@home.se>
Cc: Jack Howarth <howarth@bromo.msbb.uc.edu>, linux-kernel@vger.kernel.org
Subject: Re: PCI error on x86_64 2.6.13 kernel
Message-ID: <20051117162450.A21575@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <fa.gf7dlu0.a4g9qo@ifi.uio.no> <435FEFBD.8010702@home.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <435FEFBD.8010702@home.se>; from kjarvel@home.se on Wed, Oct 26, 2005 at 11:06:05PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2005 at 11:06:05PM +0200, Niklas Kallman wrote:
> Jack Howarth wrote:
> >    Has anyone reported the following? For both of the 2.6.13 based
> > kernels released so far on Fedora Core 4 for x86_64, we are seeing
> > error messages of the form...
> > 
> > Oct  3 11:21:48 XXXXX  kernel:   MEM window: d0200000-d02fffff
> > Oct  3 11:21:48 XXXXX  kernel:   PREFETCH window: disabled.
> > Oct  3 11:21:48 XXXXX  kernel: PCI: Failed to allocate mem resource #6:20000 f0000000 for 0000:09:00.0
> > 

I ran into a similar problem, and posted a fix, see
http://marc.theaimsgroup.com/?l=linux-pci&m=113225006603745&w=2

Can you try it to see if this problem goes away?

thanks,
Rajesh

