Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261448AbTAOEGq>; Tue, 14 Jan 2003 23:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261456AbTAOEGn>; Tue, 14 Jan 2003 23:06:43 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:51857 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S261448AbTAOEGl>; Tue, 14 Jan 2003 23:06:41 -0500
From: Ian Wienand <ianw@gelato.unsw.edu.au>
To: Con Kolivas <conman@kolivas.net>
Date: Wed, 15 Jan 2003 15:15:24 +1100
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Aggelos Economopoulos <aoiko@cc.ece.ntua.gr>,
       Cliff White <cliffw@osdl.org>
Subject: Re: [ANNOUNCE] contest benchmark v0.60
Message-ID: <20030115041524.GE21742@cse.unsw.edu.au>
References: <1042500483.3e234b8335def@kolivas.net> <200301151416.54557.conman@kolivas.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301151416.54557.conman@kolivas.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2003 at 02:16:48PM +1100, Con Kolivas wrote:
> Ok some mildly annoying bugs have already shown up in this release.
> 
> I've put up a contest-0.61pre on the contest website that addresses the one 
> which ruins the results and has some of the changes going into 0.61

Con/Aggelos,

What was the motivation for re-writing in C?

I've done some hacking on the old version here, and so I realise that
such a big shell script was getting a little out of hand, but surely
perl or python is a better option for this application?

If it's going to stay in C maybe we could integrate profiling support
from /proc/profile, bypassing readprofile?  One of the guys here
recently wanted to get profiling information from his program, and it
would have been really good to have a library that could reset, start,
pause and return in some format the profiling data.  If you think your
users might be interested in profile outputs I can write something
maybe we can both use.

-i
ianw@gelato.unsw.edu.au
http://www.gelato.unsw.edu.au
