Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262915AbUB1B7w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 20:59:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262934AbUB1B7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 20:59:52 -0500
Received: from inventor.gentoo.org ([216.223.235.2]:384 "EHLO meep.gentoo.org")
	by vger.kernel.org with ESMTP id S262915AbUB1B7v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 20:59:51 -0500
Subject: 2.6.3-bk9 QA testing: firewire good, USB printing dead
From: Daniel Robbins <drobbins@gentoo.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Gentoo Technologies, Inc.
Message-Id: <1077933682.14653.23.camel@wave.gentoo.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 27 Feb 2004 19:01:22 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

Ben Collins pointed me to 2.6.3-bk9 for my firewire troubles, and I'm
happy to report that firewire is working like a champ -- never better.
I'm burning 3 CDs simultaneously via firewire (2 controllers) with no
problems. I expect 4 simultaneous burns will also work well. My devices
have Oxford 911 chips, controllers are soundblaster audigy and a generic
3-port 1394a card.

However, 2.6.3-bk9's USB printing support appears to be dead. I can't
get it to work reliably. Tested on Epson Stylus Photo 960 and a Brother
Laser printer. catting files to /dev/usb/lp? tends to fail (process will
get "stuck") and printer data stops flowing. This is on an Athlon XP
(NForce2) system using the on-board USB. The official 2.6.3 release
works fine. I'd expect these USB printing death symptoms to be easily
reproducable on quite a few systems -- the problems hit me in the first
few seconds of print testing. If they end up being more elusive, I can
try to dig up more info for anyone who's interested in trying to isolate
the problem.

Regards,

Daniel

