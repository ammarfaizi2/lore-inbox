Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbVIRIth@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbVIRIth (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 04:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbVIRIth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 04:49:37 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:46001 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S1750714AbVIRItg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 04:49:36 -0400
Date: Sun, 18 Sep 2005 10:49:35 +0200
From: bert hubert <bert.hubert@netherlabs.nl>
To: Maurice Volaski <mvolaski@aecom.yu.edu>
Cc: linux-kernel@vger.kernel.org, colding@omesc.com
Subject: Re: Segfaults in mkdir under high load. Software or hardware?
Message-ID: <20050918084935.GB9981@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <bert.hubert@netherlabs.nl>,
	Maurice Volaski <mvolaski@aecom.yu.edu>,
	linux-kernel@vger.kernel.org, colding@omesc.com
References: <mailman.3.1123153201.10574.linux-kernel-daily-digest@lists.us.dell.com> <a0623096fbf5261b770eb@[129.98.90.227]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0623096fbf5261b770eb@[129.98.90.227]>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 17, 2005 at 08:20:40PM -0400, Maurice Volaski wrote:

> >If you reproduce with an unpatched kernel and an unpatched compiler, you 
> >are
> >much more likely to get attention. Your problem might also just go away.
> 
> I have been seeing a similar thing:
> 
> ./current:Sep 17 18:00:01 [kernel] mkdir[7696]: segfault at 
> 0000000000000000 rip 000000000040184d rsp 00007fffff826350 error 4
> 
> I'm using the plain 2.6.13 (from gentoo vanilla sources), though it 
> was compiled with
> gcc version 3.4.4 (Gentoo 3.4.4-r1, ssp-3.4.4-1.0, pie-8.7.8)

And now try with a regular gcc. In the meantime I haven't seen this problem
reported by any else, you are the second gentoo user to report it.

Good luck!

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
