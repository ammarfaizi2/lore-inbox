Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261271AbSIWUDD>; Mon, 23 Sep 2002 16:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261358AbSIWUBW>; Mon, 23 Sep 2002 16:01:22 -0400
Received: from packet.digeo.com ([12.110.80.53]:29836 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261357AbSIWUAt>;
	Mon, 23 Sep 2002 16:00:49 -0400
Message-ID: <3D8F741E.578D49C4@digeo.com>
Date: Mon, 23 Sep 2002 13:05:50 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Shawn Starr <spstarr@sh0n.net>
CC: "Stephen C. Tweedie" <sct@redhat.com>,
       Andreas Dilger <adilger@clusterfs.com>,
       Con Kolivas <conman@kolivas.net>, linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] EXT3 vs EXT2 results with rmap14a and testing with 
 contest 0.34
References: <200209182118.12701.spstarr@sh0n.net> <3D896F73.5D1265B5@digeo.com> <20020923200337.L11682@redhat.com> <200209231600.03978.spstarr@sh0n.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Sep 2002 20:05:53.0726 (UTC) FILETIME=[9F0AADE0:01C2633C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shawn Starr wrote:
> 
> On September 23, 2002 03:03 pm, Stephen C. Tweedie wrote:
> > Hi,
> >
> > On Wed, Sep 18, 2002 at 11:32:19PM -0700, Andrew Morton wrote:
> > > I had a little patch.  Stephen is working on the big fix.
> >
> > It passed an overnight Cerberus at the end of last week.  :-)
> > Checking into CVS shortly, then I need to set up a pile of recovery
> > tests to make sure it's still writing everything it needs to in time.
> >
>
> Which branch of the kernel is this going into? an -ac branch or 2.5 bk?
> 

The way it usually goes is that Stephen checks it into ext3 CVS (based
off current Marcelo kernel) and I port it up to 2.5.
