Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <157339-13684>; Thu, 7 Jan 1999 14:54:50 -0500
Received: from caffeine.ix.net.nz ([203.97.100.28]:1194 "EHLO caffeine.ix.net.nz" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <157665-13684>; Thu, 7 Jan 1999 02:29:29 -0500
Date: Thu, 7 Jan 1999 22:54:53 +1300
From: Chris Wedgwood <cw@ix.net.nz>
To: scherrey@proteus-tech.com
Cc: Kurt Garloff <K.Garloff@ping.de>, Linux kernel list <linux-kernel@vger.rutgers.edu>
Subject: Re: [PATCH] HZ change for ix86
Message-ID: <19990107225453.A1900@caffeine.ix.net.nz>
References: <19990105094830.A17862@kg1.ping.de> <3692DF1C.C03DD162@gte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95i
In-Reply-To: <3692DF1C.C03DD162@gte.net>; from Benjamin Scherrey on Tue, Jan 05, 1999 at 10:57:16PM -0500
X-No-Archive: Yes
Sender: owner-linux-kernel@vger.rutgers.edu

On Tue, Jan 05, 1999 at 10:57:16PM -0500, Benjamin Scherrey wrote:

>     Thanx for the insightful information about the impact of
> changing the HZ values. Questions: a) how platform specific is this
> setting (i86, ALPHA, et al)

each platform is differnet, for example, x86 is 100, alpha is 1024.
Some RT people use 10,000 or so on x86 I beleive (you can also do
this to get more fine frained shaper control)

> and b) Does increasing the HZ value increases context switches or
> increases duration of each context?

no

> This sounds like an excellent developer's config option to me....

why? what are you truing to achieve?



-cw

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
