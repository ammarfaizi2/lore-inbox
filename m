Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262258AbTDKXbw (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 19:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262674AbTDKXba (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 19:31:30 -0400
Received: from uucp.cistron.nl ([62.216.30.38]:8969 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S262587AbTDKX1Y (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 19:27:24 -0400
From: miquels@cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: [ANNOUNCE] udev 0.1 release
Date: Fri, 11 Apr 2003 23:39:07 +0000 (UTC)
Organization: Cistron Group
Message-ID: <b77jmr$31d$1@news.cistron.nl>
References: <20030411172011.GA1821@kroah.com> <20030411182313.GG25862@wind.cocodriloo.com> <3E970A00.2050204@cox.net> <20030411190717.GH1821@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1050104347 3117 62.216.29.200 (11 Apr 2003 23:39:07 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030411190717.GH1821@kroah.com>,
Greg KH  <greg@kroah.com> wrote:
>I agree too.  Having /sbin/hotplug send events to a pipe where a daemon
>can get them from makes a lot of sense.  It will handle most of the
>synchronization and spawning a zillion tasks problems.

Why not serialize /sbin/hotplug at the kernel level. Queue hotplug
events and only allow one /sbin/hotplug to run at the same time.

Mike.

