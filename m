Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261256AbVEPDIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbVEPDIN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 23:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261257AbVEPDIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 23:08:13 -0400
Received: from vms048pub.verizon.net ([206.46.252.48]:65494 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S261256AbVEPDIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 23:08:06 -0400
Date: Sun, 15 May 2005 23:08:04 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Disk write cache (Was: Hyper-Threading Vulnerability)
In-reply-to: <42880620.8000300@rtr.ca>
To: linux-kernel@vger.kernel.org
Message-id: <200505152308.04960.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <1115963481.1723.3.camel@alderaan.trey.hu>
 <200505152156.18194.gene.heskett@verizon.net> <42880620.8000300@rtr.ca>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 15 May 2005 22:32, Mark Lord wrote:
> >took place on another list, and wrote a test gizmo that copied a
> >large file, then slept for 1 second and issued a sync command.  No
> >drive led activity until the usual 5 second delay of the
> > filesystem had expired.  To me, that indicated that the sync
> > command was being
>
>There's your clue.  The drive LEDs normally reflect activity
>over the ATA bus (the cable!). If they're not on, then the drive
>isn't receiving data/commands from the host.
>
>Cheers

That was my theory too Mark, but Jeff G. says its not a valid 
indicator.  So who's right?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.34% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
