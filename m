Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261647AbVDSUBS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261647AbVDSUBS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 16:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbVDSUBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 16:01:18 -0400
Received: from ns.schottelius.org ([213.146.113.242]:21517 "HELO
	ei.schottelius.org") by vger.kernel.org with SMTP id S261647AbVDSUBP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 16:01:15 -0400
Date: Tue, 19 Apr 2005 22:00:12 +0200
From: Nico Schottelius <nico-kernel@schottelius.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       linux-kernel@vger.kernel.org
Subject: Re: /proc/cpuinfo format - arch dependent!
Message-ID: <20050419200011.GB16594@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	Lee Revell <rlrevell@joe-job.com>,
	Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
	linux-kernel@vger.kernel.org
References: <20050419121530.GB23282@schottelius.org> <20050419132417.GS17865@csclub.uwaterloo.ca> <1113938220.20178.0.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1113938220.20178.0.camel@mindpipe>
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.11.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell [Tue, Apr 19, 2005 at 03:17:00PM -0400]:
> On Tue, 2005-04-19 at 09:24 -0400, Lennart Sorensen wrote:
> > On Tue, Apr 19, 2005 at 02:15:30PM +0200, Nico Schottelius wrote:
> > > When I wrote schwanz3(*) for fun, I noticed /proc/cpuinfo
> > > varies very much on different architectures.
> > > 
> > > Is it possible to make it look more identical (as far as the different
> > > archs allow it)?
> > > 
> > > So that one at least can count the cpus on every system the same way.
> > > 
> > > If so, who would the one I should contact and who would accept / verify
> > > a patch doing that?
> > 
> > If you change it now, how many tools would break?
> > 
> 
> Lots.  Please don't change the format of /proc/cpuinfo.

Can you tell me which ones?

And if there are really that many tools, which are dependent on
those information, wouldn't it be much more senseful to make
it (as far as possible) the same?

I must say I was really impressed, how easy I got the number of
cpus on *BSD (I am not a bsd user, still impressed).

They also have the same format on every arch and mostly the same
between different bsds (as far as I have seen).

In general, where are the advantages of having very different cpuinfo
formats? Tools would need to know less about the arch and could
depend on "I am on Linux" only.

Just some thoughts,

Nico

> 
> Lee
> 
> 

-- 
Keep it simple & stupid, use what's available.
Please use pgp encryption: 8D0E 27A4 is my id.
http://nico.schotteli.us | http://linux.schottelius.org
