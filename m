Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135240AbRDZJTW>; Thu, 26 Apr 2001 05:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135242AbRDZJTC>; Thu, 26 Apr 2001 05:19:02 -0400
Received: from pipt.oz.cc.utah.edu ([155.99.2.7]:60590 "EHLO
	pipt.oz.cc.utah.edu") by vger.kernel.org with ESMTP
	id <S135239AbRDZJSt>; Thu, 26 Apr 2001 05:18:49 -0400
Date: Thu, 26 Apr 2001 03:18:41 -0600 (MDT)
From: james rich <james.rich@m.cc.utah.edu>
To: "Andrew B. Cramer" <andrew.cramer@cramer-ts.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: routing & ipchains
In-Reply-To: <3AE6208C.8379.146C84FE@localhost>
Message-ID: <Pine.GSO.4.05.10104260312270.4069-100000@pipt.oz.cc.utah.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Apr 2001, Andrew B. Cramer wrote:

> Greetings All,

Hey Andy - haven't heard from you since work on a replacement linuxHQ (ahh
- those were the days, lot's of free time :) )

> 	After upgrading from kernel 2.0.38 w/ slackware-3.4 to
> kernel 2.2.16 w/ slackware-7.1 I have developed the following
> routing problems.

When upgrading slackware (not a complete reinstall) it doesn't replace you
rc scripts in /etc/rc.d.  2.2.x has a /proc entry to enable forwarding.
You need to echo 1 > /proc/sys/net/ipv4/ip_forward to enable forwarding.
Newer slackware does this in /etc/rc.d/rc.inet2.

I'm not sure this is your problem.  If you installed slackware new without
upgrading this probably isn't the answer.

James Rich
james.rich@m.cc.utah.edu

