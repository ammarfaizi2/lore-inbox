Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932513AbWF0SJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932513AbWF0SJM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 14:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932523AbWF0SJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 14:09:11 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:4653 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932519AbWF0SJK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 14:09:10 -0400
Date: Tue, 27 Jun 2006 20:10:45 +0200
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.17-git broke suspend!
Message-ID: <20060627181045.GA32115@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The git tree from yesterday and as of right now doesn't suspend on my
laptop. It does it's regular thing, then hits:

[...]
Stopping tasks:
===========================================================================================|
eth1: Going into suspend...
Class driver suspend failed for cpu0
Could not power down device `×1x: error -22
Some devices failed to power down

Incidentally, /sys/devices/system/cpu/cpu0/ is also empty on this
kernel. Some new magic option that needs to be enabled? Not suspending
sucks, cpufreq not working sucks as well (I'm stuck on 800MHz).

-- 
Jens Axboe

