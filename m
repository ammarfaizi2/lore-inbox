Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317414AbSFXG1G>; Mon, 24 Jun 2002 02:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317023AbSFXG1F>; Mon, 24 Jun 2002 02:27:05 -0400
Received: from svr.cih.com ([204.69.206.128]:55257 "HELO cih.com")
	by vger.kernel.org with SMTP id <S317078AbSFXG1E>;
	Mon, 24 Jun 2002 02:27:04 -0400
Date: Sun, 23 Jun 2002 23:27:00 -0700 (PDT)
From: "Craig I. Hagan" <hagan@cih.com>
To: Sandy Harris <pashley@storm.ca>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux, the microkernel (was Re: latest linus-2.5 BK broken)
In-Reply-To: <3D15E629.1706DE98@storm.ca>
Message-ID: <Pine.LNX.4.44.0206232323250.20806-100000@svr.cih.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Also, it isn't as clear that clustering experience applies. Are clusters
> that size built hierachically? Is a 1024-CPU Beowulf practical, and if so
> do you build it as a Beowulf of 32 32-CPU Beowulfs? Is something analogous
> required in the OSlet approach? would it work?

a system of that size has many "practical" applications. It *can* be done
without partitioning it into a tree hierarchy, however, you will need a very
capable interconnect (quadrics and myrinet come to mind). Tt that you'll have a
tiered switching hierarchy even if the nodes are presented in a flat layer.

IMHO nearly any level of breakout for grid computing (basically a cluster
hierarchy) starts to become interesting as a function of your app/problem size
and how many simultanous jobs you are running.

Of course, we can stop and hit reality for a second: not many people can afford
a 1024 cpu cluster, hence the proliferation of smaller ones ;)


-- craig



	  .-    ... . -.-. .-. . -    -- . ... ... .- --. .

Craig I. Hagan     "It's a small world, but I wouldn't want to back it up"
hagan(at)cih.com        "True hackers don't die, their ttl expires"
  	"It takes a village to raise an idiot, but an idiot can raze a village"

	Stop the spread of spam, use a sendmail condom!
	     http://www.cih.com/~hagan/smtpd-hacks

                       In Bandwidth we trust


