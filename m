Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262159AbVGKQIS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262159AbVGKQIS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 12:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262143AbVGKQFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 12:05:47 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:35793 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262148AbVGKQFf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 12:05:35 -0400
Date: Mon, 11 Jul 2005 09:05:05 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Hal Rosenstock <halr@voltaire.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH 3/27] Add MAD helper functions
Message-ID: <20050711160505.GA15937@us.ibm.com>
References: <1121089079.4389.4511.camel@hal.voltaire.com> <200507111839.41807.adobriyan@gmail.com> <1121094791.4389.4591.camel@hal.voltaire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121094791.4389.4591.camel@hal.voltaire.com>
X-Operating-System: Linux 2.6.13-rc2 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.07.2005 [11:30:23 -0400], Hal Rosenstock wrote:
> On Mon, 2005-07-11 at 10:39, Alexey Dobriyan wrote:
> > On Monday 11 July 2005 17:48, Hal Rosenstock wrote:
> > > Add new helper routines for allocating MADs for sending and formatting
> > > a send WR.
> > 
> > > -- linux-2.6.13-rc2-mm1/drivers/infiniband2/core/mad.c
> > > +++ linux-2.6.13-rc2-mm1/drivers/infiniband3/core/mad.c
> > 				   ^^^^^^^^^^^
> > Ick. You'd better have linux-2.6.13-rc2-mm1-[0123...].
> 
> Shall I resubmit with linux-2.6.13-rc2-mm1-[0123...] ?

Do these patches even apply with -p1 with these odd directories? I think
it will try to find the addition context in a file which doesn't exist
(because the directory, e.g. infiniband3, does not). I notice that every
patch increments these values. I think you only want to differentiate
between the kernels, not between particular directories in the kernel.

Thanks,
Nish
