Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbWGCGbw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWGCGbw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 02:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbWGCGbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 02:31:52 -0400
Received: from theorix.CeNTIE.NET.au ([202.9.6.84]:47337 "HELO
	theorix.centie.net.au") by vger.kernel.org with SMTP
	id S1750720AbWGCGbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 02:31:51 -0400
Subject: Re: Suspend to RAM regression tracked down
From: Jean-Marc Valin <jean-marc.valin@usherbrooke.ca>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: cpufreq@lists.linux.org.uk, Linux Kernel <linux-kernel@vger.kernel.org>,
       venkatesh.pallipadi@intel.com
In-Reply-To: <44A8B2FC.6080806@goop.org>
References: <1151837268.5358.10.camel@idefix.homelinux.org>
	 <44A80B20.1090702@goop.org> <1151880764.5358.32.camel@idefix.homelinux.org>
	 <44A8B2FC.6080806@goop.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 03 Jul 2006 16:31:47 +1000
Message-Id: <1151908307.8325.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-07-02 at 23:02 -0700, Jeremy Fitzhardinge wrote: 
> Jean-Marc Valin wrote:
> > Any link to the patch and the thread about the problem (if any)? Also,
> > was the race introduced in 2.6.12-rc5-git6? If not, it's a completely
> > different problem because my machine worked fine with 2.6.12-rc5-git5.
> >   
> 
> It's in the thread on the cpufreq list titled "ondemand vs suspend"; 
> Venkatesh Pallipadi posted the patch.

Just read the thread and it's not clear to me whether it's the same
problem. Venkatesh, does the thread describe the same as this bug:
http://bugzilla.kernel.org/show_bug.cgi?id=6166
which appeared in 2.6.12-rc5-git6 or is it a separate problem?

	Jean-Marc
