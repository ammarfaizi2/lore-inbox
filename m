Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266867AbUAXFxb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 00:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266868AbUAXFxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 00:53:31 -0500
Received: from sitemail3.everyone.net ([216.200.145.37]:36799 "EHLO
	omta06.mta.everyone.net") by vger.kernel.org with ESMTP
	id S266867AbUAXFx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 00:53:29 -0500
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
Date: Fri, 23 Jan 2004 21:53:28 -0800 (PST)
From: john moser <bluefoxicy@linux.net>
To: linux-kernel@vger.kernel.org
Subject: shmat -- wtf owns it?
Reply-To: bluefoxicy@linux.net
X-Originating-Ip: [68.33.187.247]
Message-Id: <20040124055328.008343950@sitemail.everyone.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay I've been back and forth through ipc/shm.c and shm.h about 3 or 4 times.  Yes,
rather cursory of me to not read it 40 times.  But, seriously.

Who the FUCK owns a shm segment?  I can't see a way to check the creator of a segment
of shm in sys_shmat() in ipc/shm.c and I really tried too.

_____________________________________________________________
Linux.Net -->Open Source to everyone
Powered by Linare Corporation
http://www.linare.com/
