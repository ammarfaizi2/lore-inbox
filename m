Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbTJHXYS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 19:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbTJHXYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 19:24:18 -0400
Received: from devil.servak.biz ([209.124.81.2]:44488 "EHLO devil.servak.biz")
	by vger.kernel.org with ESMTP id S261823AbTJHXYR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 19:24:17 -0400
Subject: Re: Software RAID5 with 2.6.0-test
From: Torrey Hoffman <thoffman@arnor.net>
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <yw1xoewrfizk.fsf@users.sourceforge.net>
References: <yw1xoewrfizk.fsf@users.sourceforge.net>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1065655452.13572.50.camel@torrey.et.myrio.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 08 Oct 2003 16:24:12 -0700
Content-Transfer-Encoding: 8BIT
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - devil.servak.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - arnor.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My experience:

I'm running 2.6.0-test6 on a dual pentium 3 with software raid-5 across
5 disks on two different IDE hardware controllers (VIA and Promise). 
I've got a 224 GB reiserfs partition on that.  

After 8 days uptime, it doesn't seem to have blown up yet.  However I
don't stress it heavily - just a nightly rsync or two which does a lot
of reading and writing, and I export my music collection on it via NFS,
which is a low level of read activity.  

I mirror the RAID to an external firewire drive nightly for backup,
since I don't trust it 100% either, yet.  

I'd also be interested to know if there are known problems with software
RAID5 in 2.6.

Hope that helps,

Torrey Hoffman
thoffman@arnor.net

On Wed, 2003-10-08 at 15:43, Måns Rullgård wrote:
> Is software RAID5 stable in Linux 2.6.0-test7?  A while back I tried
> running a software RAID5 with a 2.6.0-test kernel, and had to spend
> the evening running fsck.  The corruption could have been caused by
> something other than the RAID layer.  So, is it considered safe to use
> RAID5 in 2.6.0 kernels?  I sort of dislike the try and see approach
> with matters like this.
-- 
Torrey Hoffman <thoffman@arnor.net>

