Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263728AbUDSHfP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 03:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263808AbUDSHfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 03:35:15 -0400
Received: from web90005.mail.scd.yahoo.com ([66.218.94.63]:62598 "HELO
	web90005.mail.scd.yahoo.com") by vger.kernel.org with SMTP
	id S263728AbUDSHfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 03:35:08 -0400
Message-ID: <20040419073507.8572.qmail@web90005.mail.scd.yahoo.com>
Date: Mon, 19 Apr 2004 00:35:07 -0700 (PDT)
From: Phy Prabab <phyprabab@yahoo.com>
Subject: Question on forcing cache data to write out
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sirs,

I am interested in understanding how tot tune the 2.6
kernel such that I can get the WM to write out data
that is held within the "cache".

My situtation is that I have a NFS file server that
gets data in bursts.  The first couple of burst move
quickly, but once the system memory becomes filled,
mostly held in "cache", then my NFS performance drops.
 The issue here is how to get the VM to write out the
data held within the cache when times are slow (which
amounts to 90% of the time)?  I have played a little
bit with the /proc/sys/vm/dirty_ratio, etc with out
much help.

Any suggestions?

Thank you for your valuable time.
Phy Prabab
 


	
		
__________________________________
Do you Yahoo!?
Yahoo! Photos: High-quality 4x6 digital prints for 25¢
http://photos.yahoo.com/ph/print_splash
