Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266074AbUBCUPG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 15:15:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266165AbUBCUPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 15:15:06 -0500
Received: from ee.oulu.fi ([130.231.61.23]:39905 "EHLO ee.oulu.fi")
	by vger.kernel.org with ESMTP id S266074AbUBCUPD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 15:15:03 -0500
Date: Tue, 3 Feb 2004 22:15:02 +0200
From: Flexy <flexy@ee.oulu.fi>
To: linux-kernel@vger.kernel.org
Subject: Keventd robbing CPU time 2.4.25-pre8
Message-ID: <20040203201502.GA18376@ee.oulu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First, I have not subscribed, so put me on cc list on this matter, thanks.

OK, using 2.4.23 keventd is not using much CPU time, but when I finally 
upgraded to 2.4.25-pre8, I noticed that keventd is taking even more CPU 
time than X. I've tried the 2.6 series too, but I've noticed that there 
is a event/0 (IIRC) process peaking every second or two, much like keventd 
in 2.4.25-pre8. Dunno if this is the same issue or not. I've tried with 
and without preemptible kernel. 

I'm using vanilla kernels from kernel.org on HP Omnibook 4150, PIII 500, 
with BX chipset. Configuration should be the same in 2.4 series kernels. 


Flexy
