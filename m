Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261921AbTDEHXz (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 02:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbTDEHXz (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 02:23:55 -0500
Received: from userk185.dsl.pipex.com ([62.188.58.185]:58752 "HELO
	userk185.dsl.pipex.com") by vger.kernel.org with SMTP
	id S261921AbTDEHXy (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 5 Apr 2003 02:23:54 -0500
From: "Sean Hunter" <sean@uncarved.com>
Date: Sat, 5 Apr 2003 07:35:25 +0000
To: linux-kernel@vger.kernel.org
Subject: Oops every write with ext3 + sync + data=journal
Message-ID: <20030405073525.GC2806@uncarved.com>
Mail-Followup-To: Sean Hunter <sean@uncarved.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there

I got the 2.5 series functional here for the first time by changing the
mount options on one of my filesystems.  It would crash everytime syslog
tried to write to /var, which was mounted
rw,sync,data=journal,nosuid,nodev

I changed it to rw,nosuid,nodev and the box is now happy.  I'll change
it back sometime to capture the oops if someone cares.

Sean

