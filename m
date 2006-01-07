Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030605AbWAGVzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030605AbWAGVzT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 16:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030606AbWAGVzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 16:55:19 -0500
Received: from liaag1ac.mx.compuserve.com ([149.174.40.29]:53725 "EHLO
	liaag1ac.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1030605AbWAGVzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 16:55:18 -0500
Date: Sat, 7 Jan 2006 16:51:48 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.6.15-mm2
To: Andrew Morton <akpm@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, Dave Jones <davej@codemonkey.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200601071654_MC3-1-B57D-1B7C@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

syfs-crash-debugging.patch (from Adrian Bunk) has this:

+               printk(KERN_ALERT "last sysfs file: %s\n", last_sysfs_file);

but davej has changed all the messages around it to KERN_EMERG in his earlier
printk-levels-for-i386-oops-code.patch

-- 
Chuck
Currently reading: _Sleepside: The Collected Fantasies Of Greg Bear_
