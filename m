Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932430AbWGLFJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbWGLFJs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 01:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbWGLFJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 01:09:48 -0400
Received: from mga05.intel.com ([192.55.52.89]:44683 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S932430AbWGLFJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 01:09:47 -0400
X-IronPort-AV: i="4.06,230,1149490800"; 
   d="scan'208"; a="96691540:sNHT28801409"
Subject: Re: [PATCH 1/6] PCI-Express AER implemetation
From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
To: Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       linux-pci maillist <linux-pci@atrey.karlin.mff.cuni.cz>,
       Tom Long Nguyen <tom.l.nguyen@intel.com>
In-Reply-To: <20060712041847.GA20793@kroah.com>
References: <1152668200.28493.178.camel@ymzhang-perf.sh.intel.com>
	 <20060712041847.GA20793@kroah.com>
Content-Type: text/plain
Message-Id: <1152680856.28493.204.camel@ymzhang-perf.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Wed, 12 Jul 2006 13:07:36 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-07-12 at 12:18, Greg KH wrote:
> On Wed, Jul 12, 2006 at 09:36:40AM +0800, Zhang, Yanmin wrote:
> > I changed a little about the patches, so resend and cc to Greg.
> > 
> > Greg,
> > 
> > Could you consider for your testing tree?
> 
> Two comments on this series:
Thanks for your kind comments!

>   - the pci_regs.h change I can take right now, that's in the standard
>     so it can't hurt to add it now, right?  Is this ok?
It's ok.

> 
>   - the patches break the build if you try to build things without the
>     whole series applied.  That's not good for users running 'git
>     bisect' on Linus's tree.  Can you redo the series so this doesn't
>     happen?
I will try to separate them more reasonably, but the new
patch might be too big to be sent to LKML.
