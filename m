Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267164AbUHITeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267164AbUHITeu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 15:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266919AbUHITcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 15:32:09 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:44511 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S267170AbUHITbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 15:31:05 -0400
Date: Mon, 9 Aug 2004 15:29:07 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Robert Love <rml@ximian.com>
Cc: Michael Clark <michael@metaparadigm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel events layer
Message-ID: <20040809132907.GA1792@openzaurus.ucw.cz>
References: <1090604517.13415.0.camel@lucy> <4101D14D.6090007@metaparadigm.com> <1090638881.2296.14.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1090638881.2296.14.camel@localhost>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Should there be some sharing with the device naming of sysfs or are
> > will we introduce a new one? ie sysfs uses:
> >
> > devices/system/cpu/cpu0/<blah>
> >
> > Would it be a better way to have a version that takes struct kobject
> > to enforce consistency in the device naming scheme. This also means
> > userspace would automatically know where to look in /sys if futher
> > info was needed.
> 
> No, we want to give an interface that matches the sort of provider URI
> used by object systems such as CORBA, D-BUS, and DCOP.  We also do _not_
> want to put policy in the kernel.

Funny... you want to create new namespace and argue "no policy".

If you want to translate it to something URI-like, you should
do that in userspace. 

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

