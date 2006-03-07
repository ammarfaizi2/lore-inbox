Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752023AbWCGIK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752023AbWCGIK2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 03:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752025AbWCGIK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 03:10:28 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:30126 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1752023AbWCGIK2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 03:10:28 -0500
Date: Tue, 7 Mar 2006 13:39:22 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       fabbione@ubuntu.com, akpm@osdl.org
Subject: Re: VFS nr_files accounting
Message-ID: <20060307080922.GC5946@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20060306.123904.35238417.davem@davemloft.net> <20060307064120.GA5946@in.ibm.com> <440D2DDA.7040209@yahoo.com.au> <20060306.230030.131765838.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060306.230030.131765838.davem@davemloft.net>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2006 at 11:00:30PM -0800, David S. Miller wrote:
> From: Nick Piggin <nickpiggin@yahoo.com.au>
> Date: Tue, 07 Mar 2006 17:53:14 +1100
> 
> > The other thing that is typically done for regressions like these
> > close to release time is to revert the offending changes. I figure
> > that in this case, such an option is probably _more_ risky.
> 
> Especially since we're talking about something that went into
> 2.6.14

Without a doubt, yes. Waaaay more risky. Compared to that the
rcu-batch-tuning and fix-file-counting are a cakewalk. It would
however be nice if Christoph or Viro gives the file counting
patch a look-over just so that I didn't break any sysctl
stuff.

Thanks
Dipankar
