Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133088AbREIDQf>; Tue, 8 May 2001 23:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135822AbREIDQZ>; Tue, 8 May 2001 23:16:25 -0400
Received: from elk.aciri.org ([192.150.187.21]:20747 "EHLO elk.aciri.org")
	by vger.kernel.org with ESMTP id <S133088AbREIDQM>;
	Tue, 8 May 2001 23:16:12 -0400
Message-Id: <200105090316.f493G8i48743@elk.aciri.org>
To: "David S. Miller" <davem@redhat.com>
cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
        linux-net@vger.rutgers.edu, Sally Floyd <floyd@aciri.org>,
        kk@teraoptic.com, jitu@aciri.org, jamal <hadi@cyberus.ca>
From: Sally Floyd <floyd@aciri.org>
Subject: Re: ECN: Volunteers needed 
Date: Tue, 08 May 2001 20:16:08 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>This was the big argument I was running into from sites, "well it
>isn't standard yet, when it is we'll do something about it".  The
>larger sites like to avoid updates until absolutely necessary.

The purpose of my draft on "Inappropriate TCP Resets Considered
Harmful" is to argue that firewalls and other devices should not
send Resets in response to Reserved flags in the TCP header regardless
of the standards status of the reserved flag.  System administrators
will clearly have to decide for themselves whether they find the
argument convincing.  And my own belief is that, while working to
get the broken firewalls and such fixed, it is also not a bad idea
for TCP implementations to make sure they are as robust as possible
in the presence of such broken equipment...

- Sally
