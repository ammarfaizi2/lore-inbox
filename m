Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbWCSOGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbWCSOGY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 09:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbWCSOGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 09:06:24 -0500
Received: from rwcrmhc12.comcast.net ([204.127.192.82]:41983 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932096AbWCSOGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 09:06:24 -0500
From: Parag Warudkar <kernel-stuff@comcast.net>
To: Alexander Clouter <alex@digriz.org.uk>
Subject: Re: OOPS: 2.6.16-rc6 cpufreq_conservative
Date: Sun, 19 Mar 2006 09:06:25 -0500
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, jun.nakajima@intel.com, davej@redhat.com
References: <200603181525.14127.kernel-stuff@comcast.net> <200603190134.01833.kernel-stuff@comcast.net> <20060319120047.GA26018@inskipp.digriz.org.uk>
In-Reply-To: <20060319120047.GA26018@inskipp.digriz.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603190906.25174.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 19 March 2006 07:00, Alexander Clouter wrote:
> Well its drifted a bit, however I submitted a number of patches here about
> two weeks ago to bring it back into line and hopefully make it HOTPLUG
> safe.
>
> The new set of patches pretty much make conservative's codebase identical
> to ondemands....as no one has posted back having used these or anything
> what am I to do?!

The codebase already seems identical to ondemand - Are your patches in 
2.6.16-rc6 or -mm? If they are - let me know which. If you posted them but 
they haven't yet made it into either -mm or mainline can you please post 
links to all your patches please? I can test them.

Why do we even have conservative and ondemand as two separate modules given 
they share huge amount of code - perhaps make conservative an optional 
behaviour of ondemand or alteast make a common lib which both use?

Thanks
Parag
