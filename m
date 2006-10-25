Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030457AbWJYOei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030457AbWJYOei (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 10:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030461AbWJYOei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 10:34:38 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:15371 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1030457AbWJYOeh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 10:34:37 -0400
Date: Wed, 25 Oct 2006 10:45:28 +0000
From: Pavel Machek <pavel@ucw.cz>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org, olpc-dev@laptop.org, davidz@redhat.com,
       greg@kroah.com, mjg59@srcf.ucam.org, len.brown@intel.com,
       sfr@canb.auug.org.au, benh@kernel.crashing.org
Subject: Re: Battery class driver.
Message-ID: <20061025104528.GC4835@ucw.cz>
References: <1161627633.19446.387.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161627633.19446.387.camel@pmac.infradead.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> At git://git.infradead.org/battery-2.6.git there is an initial
> implementation of a battery class, along with a driver which makes use
> of it. The patch is below, and also viewable at 
> http://git.infradead.org/?p=battery-2.6.git;a=commitdiff;h=master;hp=linus

Thanks a lot for this work.

> I don't like the sysfs interaction much -- is it really necessary for me
> to provide a separate function for each attribute, rather than a single
> function which handles them all and is given the individual attribute as
> an argument? That seems strange and bloated.
> 
> I'm half tempted to ditch the sysfs attributes and just use a single
> seq_file, in fact.

No, please don't.

							Pavel
-- 
Thanks for all the (sleeping) penguins.
