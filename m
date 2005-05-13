Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262330AbVEMKB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262330AbVEMKB0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 06:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbVEMKB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 06:01:26 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:64697 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262325AbVEMKBD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 06:01:03 -0400
Date: Fri, 13 May 2005 12:01:18 +0200
From: Pavel Machek <pavel@suse.cz>
To: James Ketrenos <jketreno@linux.intel.com>
Cc: netdev@oss.sgi.com, kernel list <linux-kernel@vger.kernel.org>,
       jbohac@suse.cz, jbenc@suse.cz
Subject: Re: ipw2100: intrusive cleanups, working this time ;-)
Message-ID: <20050513100118.GG1780@elf.ucw.cz>
References: <20050512225026.GA2822@elf.ucw.cz> <4283FA4D.3010208@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4283FA4D.3010208@linux.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >There's a lot to clean up in header file, too... And this time it
> >actually works.
> >
> >Now, I'd like to clean it a bit more and then submit it to akpm for
> >-mm series. Will someone hate me for doing that?
> >  
> >
> Initial look over the patch looks reasonable; no functionality changes,
> just code reduction.  That said, I would like to pass it through a quick
> validation cycle before its picked up.
> 
> We submitted ipw2100-1.1.0 to netdev a month or so ago.  I would like to
> see it go in to -mm through the netdev tree.  I'll ask our QA folks to
> run this patch through a quick regression cycle here just to do a sanity
> check on it.  Assuming nothing comes up, and if Jeff hasn't merged the
> ipw2100 code yet, I'll resubmit the ipw2100 driver w/ your patch applied.

Ok. [I may try and do more similar cleanups soon.]

> Part of the process we have in place is to try and make sure that the
> versions that get picked up by distros and the majority of users have a
> 'known' level of quality.  As part of that, we only want to get changes
> pushed to -mm and eventual mainline that have gone through regression
> testing.
> 
> Sound workable?

Yes... Maybe it would be better to have regression testing between -mm
and mainline. I.e. allow "good looking" changes go to -mm, so that -mm
tree gets nice, small patches, but only dump changes from -mm to
-linus when it actually works.

								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
