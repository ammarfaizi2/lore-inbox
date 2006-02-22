Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751449AbWBVVcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbWBVVcM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 16:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbWBVVcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 16:32:12 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:61612
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751449AbWBVVcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 16:32:11 -0500
Date: Wed, 22 Feb 2006 13:32:14 -0800
From: Greg KH <greg@kroah.com>
To: Karim Yaghmour <karim@opersys.com>
Cc: Mathieu Desnoyers <compudj@krystal.dyndns.org>,
       Paul Mundt <lethal@linux-sh.org>, Tom Zanussi <zanussi@us.ibm.com>,
       linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: [PATCH, RFC] sysfs: relay channel buffers as sysfs attributes
Message-ID: <20060222213214.GA17155@kroah.com>
References: <20060219175623.GA2674@kroah.com> <20060219185254.GA13391@linux-sh.org> <17401.21427.568297.830492@tut.ibm.com> <20060220130555.GA29405@Krystal> <20060220171531.GA9381@linux-sh.org> <20060220173732.GA7238@Krystal> <20060221152102.GA20835@linux-sh.org> <20060221164852.GA6489@Krystal> <20060221174318.GB23018@kroah.com> <43FCD735.2030002@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FCD735.2030002@opersys.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 04:27:17PM -0500, Karim Yaghmour wrote:
> 
> Greg KH wrote:
> > And as a debug tool, debugfs seems like the perfict place for it, as you
> > have just stated :)
> 
> So then the statement is that debugfs is for _ALL_ kinds of debugging,
> including application debugging. IOW, anyone considering debugfs as
> an fs exclusive to kernel-developers is WRONG. IOW2, distros should
> _NOT_ shy away from enabling debugfs by default on their production
> kernels.
> 
> Right?

Sure, I don't see why not.  But if a distro doesn't include anything in
their kernels that use debugfs, then they have no reason to enable it.

thanks,

greg k-h
