Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263102AbVCDU41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263102AbVCDU41 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 15:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263099AbVCDUsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 15:48:04 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:48023 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S263111AbVCDUoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:44:13 -0500
Subject: Re: [Alsa-devel] Re: intel 8x0 went silent in 2.6.11
From: Lee Revell <rlrevell@joe-job.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Mark Canter <marcus@vfxcomputing.com>,
       Nish Aravamudan <nish.aravamudan@gmail.com>,
       Pierre Ossman <drzeus-list@drzeus.cx>,
       LKML <linux-kernel@vger.kernel.org>, alsa-devel@lists.sourceforge.net
In-Reply-To: <4228C7CE.5010109@tmr.com>
References: <Pine.LNX.4.62.0503031342270.19015@krusty.vfxcomputing.com>
	 <4227085C.7060104@drzeus.cx> <1109875926.2908.26.camel@mindpipe>
	 <4228C7CE.5010109@tmr.com>
Content-Type: text/plain
Date: Fri, 04 Mar 2005 15:44:11 -0500
Message-Id: <1109969051.6710.17.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-04 at 15:40 -0500, Bill Davidsen wrote:
> Lee Revell wrote:
> > On Thu, 2005-03-03 at 13:46 -0500, Mark Canter wrote:
> > 
> >>The same issue exists on a T42p (ICH4).  Doesn't that kind of defeat the 
> >>purpose?  The thought of having to disable the headphone jack and reenable 
> >>it each time is trivial considering you can go with the fact that sound 
> >>did not require the sound system touched under <= 2.6.10.
> > 
> > 
> > You don't have to disable and re-enable it each time, if your system is
> > configured correctly then your mixer settings will be saved.
> 
> I don't think you understand the problem. Saving the settings does help, 
> you have to change the settings every time you switch from headphones to 
> speaker. Assuming I follow the o.p. issue... alsamixer shows no "sense" 
> settings for my ASUS laptop, and I have to boot 2.4 to get sound.
> 

Thanks, I understand it now.  It looked like the same bug but there is
actually something else going on.

Lee

