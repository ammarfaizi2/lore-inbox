Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267303AbTAVEDt>; Tue, 21 Jan 2003 23:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267306AbTAVEDt>; Tue, 21 Jan 2003 23:03:49 -0500
Received: from packet.digeo.com ([12.110.80.53]:65518 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267303AbTAVEDs>;
	Tue, 21 Jan 2003 23:03:48 -0500
Date: Tue, 21 Jan 2003 20:12:52 -0800
From: Andrew Morton <akpm@digeo.com>
To: Gerhard Mack <gmack@innerfire.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: why isn't quota dependant on ext2?
Message-Id: <20030121201252.2814a186.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0301212259270.5687-100000@innerfire.net>
References: <20030121185927.3abd9298.akpm@digeo.com>
	<Pine.LNX.4.44.0301212259270.5687-100000@innerfire.net>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Jan 2003 04:12:49.0330 (UTC) FILETIME=[86781120:01C2C1CC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerhard Mack <gmack@innerfire.net> wrote:
>
> On Tue, 21 Jan 2003, Andrew Morton wrote:
> 
> > Gerhard Mack <gmack@innerfire.net> wrote:
> > >
> > > Anyone know why the quota menu option isn't dependant on ext2 since that's
> > > all it works with?
> > >
> >
> > ext3, ufs and udf also use the core quota code.
> 
> The documentation says it only works with ext2 where would I find working
> utilities to get it working on ext3 ?
> 

ext3 uses the same tools as ext2 - checkquota, quotaon, etc.

http://quota-tools.sourceforge.net/ (site seems to be broken)

