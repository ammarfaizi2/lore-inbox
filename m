Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263924AbTCWVj7>; Sun, 23 Mar 2003 16:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263925AbTCWVj6>; Sun, 23 Mar 2003 16:39:58 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63153 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S263924AbTCWVj5>;
	Sun, 23 Mar 2003 16:39:57 -0500
Message-ID: <3E7E2C5C.7000905@pobox.com>
Date: Sun, 23 Mar 2003 16:51:24 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: Robert Love <rml@tech9.net>, Martin Mares <mj@ucw.cz>,
       Alan Cox <alan@redhat.com>, Stephan von Krawczynski <skraw@ithnet.com>,
       Pavel Machek <pavel@ucw.cz>, szepe@pinerecords.com, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: Ptrace hole / Linux 2.2.25
References: <20030323193457.GA14750@atrey.karlin.mff.cuni.cz> <200303231938.h2NJcAq14927@devserv.devel.redhat.com> <20030323194423.GC14750@atrey.karlin.mff.cuni.cz> <1048448838.1486.12.camel@phantasy.awol.org> <20030323195606.GA15904@atrey.karlin.mff.cuni.cz> <1048450211.1486.19.camel@phantasy.awol.org> <402760000.1048451441@[10.10.2.4]>
In-Reply-To: <402760000.1048451441@[10.10.2.4]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
>>>But if you assume this, what are the official releases for anyway?
>>
>>Well, official releases have always been sort of arbitrary for the
>>kernel... just labeled releases along the course of development. 
>>Although with the recent addition of the -rc patches, they tend to
>>ensure the latest round of development at least resulted in a stable
>>release.  But look at all the major vendors - their 2.4.18 release, for
>>example, may include whatever the latest pre-patch was at the time.
> 
> 
> I don't agree that's always been true by any means. It may currently
> be true, but that's far from a good thing. The current state of divergance
> the distros have from mainline 2.4 is IMHO the biggest problem Linux has
> today.
> 
> The distros inherently have a conflict of interest getting changes merged
> back into mainline ... it's time consuming to do, it provides them no real
> benefit (they have to maintain their huge trees anyway), and it actively
> damages the "value add" they provide.


Just to underscore Arjan's point:  non-mainline patches are very 
actively discouraged at Red Hat.  As time progresses the maintenance 
cost of EACH non-mainline patch increases.  Non-mainline patches do not 
get the benefits of wide community testing, review, and feedback. 
Further, Red Hat employees in my experience typically land patches in 
the community _first_ -- witness my netdriver work (goes me -> Marcelo 
-> RH), DaveM's net stack work, and Alan's -ac tree.

	Jeff


