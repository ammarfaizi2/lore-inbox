Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbVH3DKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbVH3DKP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 23:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932105AbVH3DKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 23:10:15 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:62779
	"EHLO g5.random") by vger.kernel.org with ESMTP id S932100AbVH3DKO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 23:10:14 -0400
Date: Tue, 30 Aug 2005 05:09:59 +0200
From: Andrea Arcangeli <andrea@cpushare.com>
To: linux-kernel@vger.kernel.org
Subject: KLive: Linux Kernel Live Usage Monitor
Message-ID: <20050830030959.GC8515@g5.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

During the Kernel Summit somebody raised the point that it's not clear
how much testing each rc/pre/git kernel gets before the final release.

So I setup a server to track automatically the amount of testing that
each kernel gets. Clearly this will be a very rough approximation and it
can't be reliable, but perhaps it'll be useful. If this won't be useful,
the time I spent on it is very minor so no problem ;).

All the details can be found in the project website:

	http://klive.cpushare.com/

Full source (server included) is here:

	http://klive.cpushare.com/downloads/klive-0.0.tar.bz2

To run the client:

	wget http://klive.cpushare.com/klive.tac

Then at every boot (like in /etc/init.d/boot.local):

	twistd -oy klive.tac

In theory we could get rid of the client entirely and make it a kernel
config option, but I've no idea if this project is useful, so I don't
want to spend too much time on it at this point.

Thank you.
