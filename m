Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbTKDTKe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 14:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbTKDTKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 14:10:34 -0500
Received: from nat-68-172-17-106.ne.rr.com ([68.172.17.106]:10484 "EHLO
	trip.jpj.net") by vger.kernel.org with ESMTP id S261270AbTKDTKd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 14:10:33 -0500
Subject: ext3 performance inconsistencies, 2.4/2.6
From: Paul Venezia <pvenezia@jpj.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1067973024.23788.24.camel@d8000>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 04 Nov 2003 14:10:24 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been running bonnie++ filesystems testing on an IBM x335 server
recently. This box uses the MPT RAID controller, but I've disabled the
RAID and am addressing the disks individually. I'm getting wildly
different results between 2.4.20-20-9 (RedHat mod), 2.4.22 (stock), and
2.6.0-test9.

The full results are here: http://groove.jpj.net/x335-test.html

The base distro is RedHat 9, there are no extraneous daemons running or
modules loaded. I'm using a dedicated drive as the scratch directory.
I'm looking for some insight as to why I'm seeing such a disparity in
performance.

The server has Dual P4 3.06Ghz CPUs, 1.5GB RAM, two 36GB Ultra320 disks.

bonnie++ is run as

bonnie++ -d /test -s 3g -m x335-`uname -r` -n 200 -x 2 -u root -q 

Thanks 

-Paul

