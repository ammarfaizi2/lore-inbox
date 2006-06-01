Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbWFAV6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbWFAV6x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 17:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbWFAV6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 17:58:52 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:59036 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750739AbWFAV6v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 17:58:51 -0400
Date: Fri, 2 Jun 2006 07:58:26 +1000
From: Nathan Scott <nathans@sgi.com>
To: Janos Haar <djani22@netcenter.hu>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: XFS related hang (was Re: How to send a break? - dump from frozen 64bit linux)
Message-ID: <20060602075826.B530100@wobbly.melbourne.sgi.com>
References: <01b701c6818d$4bcd37b0$1800a8c0@dcccs> <20060527234350.GA13881@voodoo.jdc.home> <004501c68225$00add170$1800a8c0@dcccs> <9a8748490605280917l73f5751cmf40674fc22726c43@mail.gmail.com> <01d801c6827c$fba04ca0$1800a8c0@dcccs> <01a801c683d2$e7a79c10$1800a8c0@dcccs> <200605301903.k4UJ3xQU008919@turing-police.cc.vt.edu> <1149038431.21827.20.camel@localhost.localdomain> <20060531143849.C478554@wobbly.melbourne.sgi.com> <00f501c68488$4d10c080$1800a8c0@dcccs>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <00f501c68488$4d10c080$1800a8c0@dcccs>; from djani22@netcenter.hu on Wed, May 31, 2006 at 10:00:33AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2006 at 10:00:33AM +0200, Janos Haar wrote:
> 
> Hey, i think i found something.
> My quota on my huge device is broken.
> (inferno   -- 18014398504855404       0       0        18446744073709551519
> 0     0)

Hmm, that is interesting.  I guess you don't know whether this
accounting problem happened before you rebooted or whether it
only just got this way (after journal recovery)?

> I cant found a way to re-initialize it.
> But anyway, at this point i dont need it, trying to disable the quota usage.
> We will see....

Jan's recipe was spot on, do that.

cheers.

-- 
Nathan
