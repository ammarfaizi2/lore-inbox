Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264377AbUJRIMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264377AbUJRIMJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 04:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264503AbUJRIMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 04:12:09 -0400
Received: from mid-2.inet.it ([213.92.5.19]:9906 "EHLO mid-2.inet.it")
	by vger.kernel.org with ESMTP id S264377AbUJRIMG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 04:12:06 -0400
Date: Mon, 18 Oct 2004 10:12:17 +0200
From: Mattia Dongili <dongili@supereva.it>
To: cpufreq@www.linux.org.uk, linux-kernel@vger.kernel.org
Cc: Alexander Clouter <alex-kernel@digriz.org.uk>,
       venkatesh.pallipadi@intel.com
Subject: Re: [PATCH] cpufreq_ondemand
Message-ID: <20041018081217.GA3145@inferi.kami.home>
Mail-Followup-To: cpufreq@www.linux.org.uk, linux-kernel@vger.kernel.org,
	Alexander Clouter <alex-kernel@digriz.org.uk>,
	venkatesh.pallipadi@intel.com
References: <20041017222916.GA30841@inskipp.digriz.org.uk> <20041018072045.GA17164@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041018072045.GA17164@dominikbrodowski.de>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.9-rc3-1 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2004 at 09:20:45AM +0200, Dominik Brodowski wrote:
> Hi,
[...]
> > 2. controllable through 
> > 	/sys/.../ondemand/ignore_nice, you can tell it to consider 'nice' 
> > 	time as also idle cpu cycles.  Set it to '1' to treat 'nice' as cpu 
> > 	in an active state.
> 
> Interesting bit, IIRC some userspace tool also does that.

I'm implementing an "nice_scale" parameter in cpufreqd that offers more
control on nice cpu time. It's just a parameter (whose value must be >=
1 or if 0 don't care nice time at all) that tells _how_much_ the nice
time has to be take into consideration. It would be nice to have it in
the ondemand governor too.

bye
-- 
mattia
:wq!
