Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261180AbVAGCHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbVAGCHA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 21:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261158AbVAGCDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 21:03:32 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:56509 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261182AbVAGCC6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 21:02:58 -0500
Date: Thu, 6 Jan 2005 18:02:27 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, arjan@infradead.org,
       linux-kernel@vger.kernel.org, jtk@us.ibm.com, wtaber@us.ibm.com,
       pbadari@us.ibm.com, markv@us.ibm.com, gregkh@us.ibm.com,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] fs: Restore files_lock and set_fs_root exports
Message-ID: <20050107020227.GV1292@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050106190538.GB1618@us.ibm.com> <1105039259.4468.9.camel@laptopd505.fenrus.org> <20050106201531.GJ1292@us.ibm.com> <20050106203258.GN26051@parcelfarce.linux.theplanet.co.uk> <20050106210408.GM1292@us.ibm.com> <20050106212417.GQ26051@parcelfarce.linux.theplanet.co.uk> <20050106152621.395f935e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050106152621.395f935e.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 03:26:21PM -0800, Andrew Morton wrote:
> 
> Guys, the technical arguments are all of course correct.  But the fact
> remains that we broke things without any notice.  (Yes, perhaps someone did
> say something at sometime, but the affected party didn't know, and it's our
> job to make sure that they knew).  (These exports were removed in October -
> the IBM guys need to work out why it took so long to detect the breakage).

Indeed!

We are getting lists of symbols used by the various products, as well
as working to get them tested more frequently against kernel.org trees
instead of only against distro releases.  IBM being what it is, -finding-
all such products is a challenge, but so it goes.

							Thanx, Paul
