Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261531AbTCKTDu>; Tue, 11 Mar 2003 14:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261546AbTCKTDu>; Tue, 11 Mar 2003 14:03:50 -0500
Received: from air-2.osdl.org ([65.172.181.6]:26564 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261531AbTCKTDs>;
	Tue, 11 Mar 2003 14:03:48 -0500
Date: Tue, 11 Mar 2003 11:14:19 -0800
From: Dave Olien <dmo@osdl.org>
To: mel@csn.ul.ie
Cc: linux-kernel@vger.kernel.org
Subject: vmregress test on linux 2.5.62
Message-ID: <20030311191419.GA18449@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Mel,

I've modified your vmregress test form linux 2.4 so it works on
linux 2.5.63.  I fixed up some of the core routines to understand
new modifications to kernel vm structures, so it all compiles and 
runs.

There are still some issues with the perl scripts that collect data
and pipe it to gnuplot.  Some of the plots of vmstat output don't
work.

You can see what I've modified at the URL

	http://www.osdl.org/archive/dmo/VMREGRESS/

There's a VMR_README file that describes the files there.

