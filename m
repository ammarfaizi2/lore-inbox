Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752124AbWCGI4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752124AbWCGI4a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 03:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752125AbWCGI4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 03:56:30 -0500
Received: from trider-g7.fabbione.net ([195.22.207.161]:3809 "EHLO
	trider-g7.fabbione.net") by vger.kernel.org with ESMTP
	id S1752124AbWCGI4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 03:56:30 -0500
Message-ID: <440D4A84.6090802@ubuntu.com>
Date: Tue, 07 Mar 2006 09:55:32 +0100
From: Fabio Massimo Di Nitto <fabbione@ubuntu.com>
User-Agent: Mail/News 1.5 (X11/20060213)
MIME-Version: 1.0
To: dipankar@in.ibm.com
CC: "David S. Miller" <davem@davemloft.net>, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org
Subject: Re: VFS nr_files accounting
References: <20060306.123904.35238417.davem@davemloft.net> <20060307064120.GA5946@in.ibm.com> <440D2DDA.7040209@yahoo.com.au> <20060306.230030.131765838.davem@davemloft.net> <20060307080922.GC5946@in.ibm.com>
In-Reply-To: <20060307080922.GC5946@in.ibm.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma wrote:
> On Mon, Mar 06, 2006 at 11:00:30PM -0800, David S. Miller wrote:
>> From: Nick Piggin <nickpiggin@yahoo.com.au>
>> Date: Tue, 07 Mar 2006 17:53:14 +1100
>>
>>> The other thing that is typically done for regressions like these
>>> close to release time is to revert the offending changes. I figure
>>> that in this case, such an option is probably _more_ risky.
>> Especially since we're talking about something that went into
>> 2.6.14
> 
> Without a doubt, yes. Waaaay more risky. Compared to that the
> rcu-batch-tuning and fix-file-counting are a cakewalk. It would
> however be nice if Christoph or Viro gives the file counting
> patch a look-over just so that I didn't break any sysctl
> stuff.
> 
> Thanks
> Dipankar

Considering the impact of the problem, wouldn't be wise to push
the fix to -stable as well?

Thanks
Fabio

-- 
I'm going to make him an offer he can't refuse.
