Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261582AbUEBDXH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbUEBDXH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 23:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbUEBDXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 23:23:07 -0400
Received: from nessie.weebeastie.net ([220.233.7.36]:21636 "EHLO
	theirongiant.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S261582AbUEBDXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 23:23:05 -0400
Date: Sun, 2 May 2004 13:22:53 +1000
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.6.6-rc3, nvidia sound, tulip eth and apic don't play well together
Message-ID: <20040502032253.GA6222@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organisation: Furball Inc.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's a case of one or the other really. If I try to use both at the same
time they both die. The ethernet driver stops transmitting packets until
I bring down the interface and then bringit back up and the sound stops
playing, period.

There are no kernel messages until the watchdog kicks in.

Turning off APIC (I compiled it out) solves the problem totally. I'm now
transferring files over the net and listening to my music without a 
problem.

-- 
    Red herrings strewn hither and yon.
