Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161152AbWJDOrn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161152AbWJDOrn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 10:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161153AbWJDOrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 10:47:43 -0400
Received: from colin.muc.de ([193.149.48.1]:27656 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1161149AbWJDOrm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 10:47:42 -0400
Date: 4 Oct 2006 16:47:36 +0200
Date: Wed, 4 Oct 2006 16:47:36 +0200
From: Andi Kleen <ak@muc.de>
To: "S.??a??lar Onur" <caglar@pardus.org.tr>
Cc: john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [Ops] 2.6.18
Message-ID: <20061004144736.GA67993@muc.de>
References: <200610010332.52509.caglar@pardus.org.tr> <1159810605.5873.4.camel@localhost.localdomain> <200610041638.25955.caglar@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610041638.25955.caglar@pardus.org.tr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2006 at 04:38:25PM +0300, S.??a??lar Onur wrote:
> 02 Eki 2006 Pts 20:36 tarihinde, john stultz ??unlar?? yazm????t??: 
> > On Sun, 2006-10-01 at 03:32 +0300, S.??a??lar Onur wrote:
> > > Hi;
> > >
> > > Here [1] are the two different panics with 2.6.18 on vmware, its
> > > reproducable on every 4-5 reboot [same config/kernel in "2.6.18 Nasty
> > > Lockup" thread, so i CC'd to that thread's posters also]
> > >
> > > [1] http://cekirdek.pardus.org.tr/~caglar/2.6.18/
> >
> > Hmmm.. That first oops looks interesting to me.
> >
> > When you say they're reproducible every 4-5 reboots, which one do you
> > mean?
> 
> For every 10 reboots first one occurs at least 6 times, 3 times second one 
> occurs and for last it boots :)

I assume it must be something specific to your configuration
or setup.

If plain 2.6.18 was that unstable we would be flooded in reports.
But that's not the case.  I also definitely don't see it on any of my systems
(except that if you use PIT time source on a multi core system 
things break on i386) 

Perhaps you list your setup and your configuration and a boot log
for the working case? I also I would really recommend to do the make 
distclean ; recompile step I mentioned earlier.

-Andi
