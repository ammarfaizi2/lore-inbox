Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbUBURDk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 12:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261587AbUBURDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 12:03:40 -0500
Received: from wwwb.webquarry.com ([209.211.232.3]:5046 "EHLO
	shell1.webquarry.com") by vger.kernel.org with ESMTP
	id S261580AbUBURDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 12:03:38 -0500
Date: Sat, 21 Feb 2004 09:03:31 -0800 (PST)
From: sford_lk@geeky-boy.com
X-X-Sender: sford@shell1.webquarry.com
To: linux-kernel@vger.kernel.org
Subject: kernel: svc: bad direction [resolved]
Message-ID: <Pine.LNX.4.44.0402210843081.27276-100000@shell1.webquarry.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had a problem with getting tons of "kernel: svc: bad direction..."
messages.  Web searches resulted in many asked questions but few
answers.  I hope it's OK for me to post an answer in the hope that
it makes it into the archives.

My problem turned out to be a Sun host with a DNS domain name in its
"/etc/defaultdomain" file.  That file is supposed to contain a NIS
domain name.  So, the Sun sat there broadcasting what I assume were
"where are you, NIS server?" requests, which Linux didn't like for
some reason.

