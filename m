Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262647AbTJJIaH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 04:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262651AbTJJIaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 04:30:07 -0400
Received: from gprs151-212.eurotel.cz ([160.218.151.212]:896 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262647AbTJJIaE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 04:30:04 -0400
Date: Fri, 10 Oct 2003 10:17:28 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: -test7: /sys/power/disk not reading right data?
Message-ID: <20031010081728.GA218@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm seeing this on -test7 (tainted:pavel, but I did not touch this
area).
								Pavel


root@amd:~# echo -n platform > /sys/power/disk
root@amd:~# dmesg | tail -1
PM: suspend-to-disk mode set to 'platform'
root@amd:~# cat /sys/power/disk
firmware
root@amd:~#

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
