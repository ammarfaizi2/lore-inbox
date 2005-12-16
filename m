Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751313AbVLPSWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbVLPSWn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 13:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbVLPSWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 13:22:42 -0500
Received: from main.gmane.org ([80.91.229.2]:5022 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751313AbVLPSWm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 13:22:42 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>
Subject: Re: [2.6 patch] i386: always use 4k stacks
Date: Fri, 16 Dec 2005 13:18:10 -0500
Message-ID: <dnv0d3$4jl$1@sea.gmane.org>
References: <20051215212447.GR23349@stusta.de> <20051215140013.7d4ffd5b.akpm@osdl.org> <20051216141002.2b54e87d.diegocg@gmail.com> <20051216140425.GY23349@stusta.de> <20051216163503.289d491e.diegocg@gmail.com> <632A9CF3-7F07-44D6-BFB4-8EAA272AF3E5@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: lmcgw.cs.sunysb.edu
User-Agent: KNode/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett wrote:

> I have yet to see any resistance to the 4Kb patch this time around
> that was not "*whine* don't break my ndiswrapper plz".   There are

I haven't seen anyone demanding others not to have 4k stacks; only requests
to leave 4k/8k stack option as it is. If _you_ want to have 4k stacks, you
already have that option. You are only pushing what you want on others and
bad mouthing people that are requesting the option to have either 4k or 8k
stacks.

> It's working partially now.  This is the time when we should really

ndiswrapper is used not just for broadcom. There are plenty of other
chipsets that don't even have a project started to write open source
driver.

> try to force ndiswrapper junkies over to the driver to get it tested
                           ^^^^^^^
Shame on you. Your last mail was a promise to be "more reserved". Even
otherwise, such profanities against a group of people are unwarranted.

To kernel developers: I have earlier requested if it is possible to create
threads with different stack sizes (e.g., 4k/8k/16k etc.) at run-time, ala
FreeBSD. In that case, one could chose whatever it is that fits their
needs. Any comments on this idea?

To those that depend on ndiswrapper to have wireless in Linux: A few days
ago I started working on NDIS implementation in user space. However, it
will take considerable time before this is usable. Moreover, I only have
hope with USB drivers. PCI/mini-PCI/PCMCIA drivers need to run interrupt
service routines, which can't be run in user space, so they won't work in
user space.

Giri

