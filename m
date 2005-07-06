Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262143AbVGFKFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262143AbVGFKFi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 06:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262079AbVGFKFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 06:05:37 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:20449 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262143AbVGFIFH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 04:05:07 -0400
Date: Wed, 6 Jul 2005 10:04:42 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Nigel Cunningham <nigel@suspend2.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       shaohua.li@intel.com
Subject: Re: [PATCH] [11/48] Suspend2 2.1.9.8 for 2.6.12: 401-e820-table-support.patch
Message-ID: <20050706080436.GA1412@elf.ucw.cz>
References: <11206164403490@foobar.com> <Pine.LNX.4.61.0507052131140.2149@montezuma.fsmlabs.com> <1120621474.4860.6.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1120621474.4860.6.camel@localhost>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > @@ -560,7 +559,7 @@ struct mtrr_value {
> > >  
> > >  static struct mtrr_value * mtrr_state;
> > >  
> > > -static int mtrr_save(struct sys_device * sysdev, u32 state)
> > > +int mtrr_save(void)
> > >  {
> > >  	int i;
> > >  	int size = num_var_ranges * sizeof(struct mtrr_value);
> > > @@ -580,28 +579,27 @@ static int mtrr_save(struct sys_device *
> > >  	return 0;
> > >  }
> > 
> > Isn't this covered by Shaohua Li's patch?
> 
> I believe so, but Shaohua Li's patch isn't merged in 2.6.12 (is it yet
> at all). This is the solution I've been using for... can't remember how
> long.

I *think* it is in -mm already.
								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
