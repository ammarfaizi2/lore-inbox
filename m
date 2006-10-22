Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422931AbWJVDWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422931AbWJVDWf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 23:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422932AbWJVDWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 23:22:34 -0400
Received: from xenotime.net ([66.160.160.81]:62392 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1422931AbWJVDWe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 23:22:34 -0400
Date: Sat, 21 Oct 2006 20:24:11 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Andy Whitcroft <apw@shadowen.org>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: 2.6.19-rc2-mm2
Message-Id: <20061021202411.ba98d880.rdunlap@xenotime.net>
In-Reply-To: <453AD48E.2060204@mbligh.org>
References: <20061020015641.b4ed72e5.akpm@osdl.org>
	<4538F12B.10609@mbligh.org>
	<453AD48E.2060204@mbligh.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Oct 2006 19:16:46 -0700 Martin J. Bligh wrote:

> Martin J. Bligh wrote:
> > Andrew Morton wrote:
> >> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc2/2.6.19-rc2-mm2/ 
> >>
> >>
> >> - Added the IOAT tree as git-ioat.patch (Chris Leech)
> >>
> >> - I worked out the git magic to make the wireless tree work
> >>   (git-wireless.patch).  Hopefully it will be in -mm more often now.
> > 
> > I think the IO & fsx problems have got better, but this one is still
> > broken, at least.
> > 
> > See end of fsx runlog here:
> > 
> > http://test.kernel.org/abat/57486/debug/test.log.1
> > 
> > which looks like this:
> > 
> > Total Test PASSED: 79
> > Total Test FAILED: 3
> >   139 ./fsx-linux -N 10000 -o 8192 -A -l 500000 -r 1024 -t 2048 -w 2048 
> > -Z -R -W test/junkfile
> >   139 ./fsx-linux -N 10000 -o 128000 -r 2048 -w 4096 -Z -R -W test/junkfile
> >   139 ./fsx-linux -N 10000 -o 8192 -A -l 500000 -r 1024 -t 2048 -w 1024 
> > -Z -R -W test/junkfile
> > Failed rc=1
> > 10/20/06-02:41:55 command complete: (1) rc=1 (TEST FAIL)
> 
> On further examination ... and rather more worryingly, this started
> between 2.6.18 and 2.6.18.1. I don't see any reiserfs patches in
> there, and possibly it's a machine config change? But rather worrying.
> 
> Where do the changelogs for the stable release kernels sit again?

duh, :)  listed at www.kernel.org, points to
http://www.kernel.org/pub/linux/kernel/v2.6/ChangeLog-2.6.18.1

---
~Randy
