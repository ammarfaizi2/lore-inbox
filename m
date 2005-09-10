Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030411AbVIJED6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030411AbVIJED6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 00:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932612AbVIJED6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 00:03:58 -0400
Received: from dial169-104.awalnet.net ([213.184.169.104]:1541 "EHLO
	raad.intranet") by vger.kernel.org with ESMTP id S932606AbVIJED6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 00:03:58 -0400
From: Al Boldi <a1426z@gawab.com>
To: Ben Greear <greearb@candelatech.com>
Subject: Re: Physical device to Kernel-netlink mapper
Date: Sat, 10 Sep 2005 07:00:28 +0300
User-Agent: KMail/1.5
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
References: <200509091538.27605.a1426z@gawab.com> <4321BF0C.2000007@candelatech.com>
In-Reply-To: <4321BF0C.2000007@candelatech.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200509100659.04295.a1426z@gawab.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Greear wrote:
> Al Boldi wrote:
> > Is there a virtual device that would allow to connect the communication
> > paths from the physical devs into the kernel netlink subsystem in a way
> > that would be more flexible than what is currently avaible?
> >
> > Something like this:
> >
> >     Kernel-netlink
> >        |
> >     virtual dev
> >        |
> > --> mapper/conf <--
> >        |
> >     physical dev(s)
> >
> > tun/tap,bridge,bond... are devs that incorporate this idea, but don't
> > allow for a flexible configuration.
>
> Please explain in more detail.

Consider the bridge:
1. Creates a virtual dev
2. Adds physical devs
3. Connects devs to each other in a fixed way

What is needed is a generalized module that allows step 3 to be completely 
flexible.

Thanks!

--
Al
