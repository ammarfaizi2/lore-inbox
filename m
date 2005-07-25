Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbVGYQeH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbVGYQeH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 12:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbVGYQeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 12:34:07 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:19851 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S261358AbVGYQeF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 12:34:05 -0400
Date: Mon, 25 Jul 2005 18:34:05 +0200
From: bert hubert <bert.hubert@netherlabs.nl>
To: Christopher Friesen <cfriesen@nortel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: do_gettimeofday monotony?
Message-ID: <20050725163404.GB12931@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <bert.hubert@netherlabs.nl>,
	Christopher Friesen <cfriesen@nortel.com>,
	linux-kernel@vger.kernel.org
References: <20050724182617.GA15707@outpost.ds9a.nl> <42E50159.6050901@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42E50159.6050901@nortel.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2005 at 11:12:25AM -0400, Christopher Friesen wrote:
> >Is do_gettimeofday supposed to be monotonous?
> 
> Nope.
> 
> > I'm seeing time go backward by tiny amounts, and then progressing.
> 
> Are you running NTP?  Corrections could cause this.

No. I am running a machine which often changes it clockspeed though. The bad
news is that I don't appear to be able to reproduce this, there must be
something specific that causes it. But then again, it wasn't a large effect.

> >Is there another monotonous clock in the kernel that doesn't wrap (all
> >that often)? Doesn't really need to be wall time.
> 
> clock_gettime()

Thank you.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
