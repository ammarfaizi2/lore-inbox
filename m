Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262005AbVBKCsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262005AbVBKCsk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 21:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbVBKCsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 21:48:40 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:8900 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262005AbVBKCsc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 21:48:32 -0500
Date: Thu, 10 Feb 2005 18:46:06 -0800
From: Chandra Seetharaman <sekharan@us.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: Matthew Dobson <colpatch@us.ibm.com>, dino@in.ibm.com, mbligh@aracnet.com,
       pwil3058@bigpond.net.au, frankeh@watson.ibm.com, dipankar@in.ibm.com,
       akpm@osdl.org, ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, Simon.Derr@bull.net, ak@suse.de,
       sivanich@sgi.com
Subject: Re: [ckrm-tech] Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-ID: <20050211024606.GB19997@chandralinux.beaverton.ibm.com>
References: <415F37F9.6060002@bigpond.net.au> <821020000.1096814205@[10.10.2.4]> <20041003083936.7c844ec3.pj@sgi.com> <834330000.1096847619@[10.10.2.4]> <1097014749.4065.48.camel@arrakis> <420800F5.9070504@us.ibm.com> <20050208095440.GA3976@in.ibm.com> <42090C42.7020700@us.ibm.com> <20050208124234.6aed9e28.pj@sgi.com> <20050209175928.GA5710@chandralinux.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050209175928.GA5710@chandralinux.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2005 at 09:59:28AM -0800, Chandra Seetharaman wrote:
> On Tue, Feb 08, 2005 at 12:42:34PM -0800, Paul Jackson wrote:
--stuff deleted---
> memset_controller would be similar to this, before pitching it I will talk
> with Matt about why he thought that there is a problem.

Talked to Matt Dobson and explained him the CKRM architecture and how
cpuset/memset can be implemented as a ckrm controller. He is now convinced
that there is no problem in making memset also a ckrm controller.

As explained in the earlier mail, memset also can be implemented in the
same way as cpuset.

> 
> If I missed some feature of cpuset that shows a bigger problem, please
> let me know.
> > 
> > In sum -- I see a potential for useful integration of cpusets and
> > scheduler domains, I'll have to leave it up to those with expertise in
> > the scheduler to evaluate and perhaps accomplish this.  I do not see any
> > useful integration of cpusets and CKRM.
> > 
> > I continue to be befuddled as to why, Matthew, you confound potential
> > cpuset-scheddomain integration with potential cpuset-CKRM integration.
> > Scheduler domains and CKRM are distinct beasts, in my book, and the
> > contemplations of cpuset integration with these two beasts are also
> > distinct efforts.
> > 
> > And cpusets and CKRM are distinct beasts.
> > 
> > But I repeat myself ...
> > 
> > -- 
> >                   I won't rest till it's the best ...
> >                   Programmer, Linux Scalability
> >                   Paul Jackson <pj@sgi.com> 1.650.933.1373, 1.925.600.0401
> > 
> > 
> > -------------------------------------------------------
> > SF email is sponsored by - The IT Product Guide
> > Read honest & candid reviews on hundreds of IT Products from real users.
> > Discover which products truly live up to the hype. Start reading now.
> > http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> > _______________________________________________
> > ckrm-tech mailing list
> > https://lists.sourceforge.net/lists/listinfo/ckrm-tech
> 
> -- 
> 
> ----------------------------------------------------------------------
>     Chandra Seetharaman               | Be careful what you choose....
>               - sekharan@us.ibm.com   |      .......you may get it.
> ----------------------------------------------------------------------
> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> ckrm-tech mailing list
> https://lists.sourceforge.net/lists/listinfo/ckrm-tech

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------
