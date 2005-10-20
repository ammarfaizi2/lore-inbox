Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932534AbVJTVCA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932534AbVJTVCA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 17:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbVJTVB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 17:01:59 -0400
Received: from moraine.clusterfs.com ([66.96.26.190]:30868 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S932534AbVJTVB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 17:01:59 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17240.1485.704010.417090@gargle.gargle.HOWL>
Date: Fri, 21 Oct 2005 01:02:05 +0400
To: Chris Boot <bootc@bootc.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Reiser4 lockups (no oops)
In-Reply-To: <4357E5A1.8000301@bootc.net>
References: <43567D80.3050304@bootc.net>
	<20051020131815.GI2811@suse.de>
	<20051020163425.z7wygjyir8lcw0gk@horde.fusednetworks.co.uk>
	<20051020162112.GT2811@suse.de>
	<4357C56B.30600@bootc.net>
	<17239.55622.86540.438878@gargle.gargle.HOWL>
	<4357E5A1.8000301@bootc.net>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Boot writes:
 > Nikita Danilov wrote:
 > 
 > >Chris Boot writes:
 > >
 > >[...]
 > >
 > > > Oh! Hehe, now I get you. However, I'm using metalog for logging, and 
 > > > modprobe loop doesn't give any output. What's interesting is that serial 
 > > > console logging dies long before metalog is started, just after my swap 
 > > > is added in fact. I'm using Gentoo.
 > > > 
 > > > Any ideas?
 > >
 > >What
 > >
 > >cat /proc/sys/kernel/printk
 > >
 > >shows after a boot?
 > >
 > > > 
 > > > Cheers,
 > > > Chris
 > >
 > >Nikita.
 > >  
 > >
 > Hi there,
 > 
 > It shows:
 > 
 > arcadia ~ # cat /proc/sys/kernel/printk
 > 1       4       1       7

That's why nothing is printed on the console. Try

echo 8 4 4 8 > /proc/sys/kernel/printk

 > 
 > Cheers,
 > Chris

Nikita.
