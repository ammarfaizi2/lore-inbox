Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261593AbREOVvs>; Tue, 15 May 2001 17:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261594AbREOVvj>; Tue, 15 May 2001 17:51:39 -0400
Received: from gw-yyz.somanetworks.com ([216.126.67.39]:26792 "EHLO
	somanetworks.com") by vger.kernel.org with ESMTP id <S261593AbREOVvZ>;
	Tue, 15 May 2001 17:51:25 -0400
Date: Tue, 15 May 2001 17:51:24 -0400
From: Mark Frazer <mjfrazer@somanetworks.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
Message-ID: <20010515175124.A4729@jimmy.yyz.somanetworks.com>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <p05100316b7272cdfd50c@[207.213.214.37]> <Pine.LNX.4.21.0105151309460.2470-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0105151309460.2470-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, May 15, 2001 at 01:18:09PM -0700
Organization: Detectable, well, not really
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> [01/05/15 16:28]:
> 
> The "eth0..N" naming is done RIGHT!

Nothing to do with the kernel but, one should then argue that the
current stuff in /etc/sysconfig/network-scripts is broken for hotplug as
placing a new network adapter into your bus will renumber your interfaces
causing them to be ifconfig'd wrongly.  You'd want to associate the IP
configuration stuff with the particular network interface, by MAC address.

As for the software-RAID getting messed up, isn't that what volume labels
are for?

What else in the current distro setups is going to need to change for
hotplug?
