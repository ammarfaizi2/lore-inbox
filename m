Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266246AbUG0Fel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266246AbUG0Fel (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 01:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266273AbUG0Fel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 01:34:41 -0400
Received: from main.gmane.org ([80.91.224.249]:1260 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266246AbUG0Fej (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 01:34:39 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joshua Kwan <joshk@triplehelix.org>
Subject: Wireless devices and route settings
Date: Mon, 26 Jul 2004 22:34:35 -0700
Message-ID: <pan.2004.07.27.05.34.35.543474@triplehelix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-68-126-193-193.dsl.pltn13.pacbell.net
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

So, I have a wireless interface on a 'guest' Linux box (running 2.6.7-rc1,
not bothered to compile a new kernel yet.) It is a fair distance away from
the access point and sometimes goes out of range.

Usually it can go out of range and come back in range without the user
noticing anything has happened. But once in a while, when the connection
is especially poor, the interface will go down and lose its default route.
When it comes back, it retains its IP, but does not keep the default route.
This makes the internet unusable on this machine until i cycle ifdown/ifup
which I cannot rely on guests to do.

There is no daemon watching the network interfaces at all that might be
doing this (I'm pretty sure), so I was hoping linux-kernel might know.

Here's to a prompt solution..

-- 
Joshua Kwan


