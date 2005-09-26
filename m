Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932461AbVIZS0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461AbVIZS0a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 14:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbVIZS0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 14:26:30 -0400
Received: from mail.cs.unm.edu ([64.106.20.33]:23748 "EHLO mail.cs.unm.edu")
	by vger.kernel.org with ESMTP id S932461AbVIZS03 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 14:26:29 -0400
Date: Mon, 26 Sep 2005 12:26:20 -0600 (MDT)
From: Sharma Sushant <sushant@cs.unm.edu>
To: linux-kernel@vger.kernel.org
Subject: APIC and Performance Counters
Message-ID: <Pine.LNX.4.62.0509261208040.11499@husband.cs.unm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
I was trying to do some performance monitoring using performance counters 
on an AMD Athlon64. I am trying to count number of retired uops (0xC1h) 
and I want to call a function after every n number of uops. I think I need 
to use APIC for this purpose and specifically APIC register for 
"perfromance counter local vector table entry" in which i can set up the 
vector which will be sent for the interrupt source. Now I am not familiar 
with setting up of vector table entries and the detailed process of how 
can I do what I want. Can anyone give some pointers where I can find more 
information on programming APIC with performance-monitoring counters or if 
some one can explain it to me, I would be thankful.
TIA
-Sushant
ps: please cc the reply to me.


--
Sushant Sharma
