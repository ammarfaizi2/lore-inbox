Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262369AbTLWXB0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 18:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262705AbTLWXB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 18:01:26 -0500
Received: from ping.ovh.net ([213.186.33.13]:7830 "EHLO ping.ovh.net")
	by vger.kernel.org with ESMTP id S262369AbTLWXBY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 18:01:24 -0500
Date: Tue, 23 Dec 2003 23:59:13 +0100
From: Octave <oles@ovh.net>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: lot of VM problem with 2.4.23
Message-ID: <20031223225913.GO30707@ovh.net>
References: <20031221001422.GD25043@ovh.net> <1071999003.2156.89.camel@abyss.local> <Pine.LNX.4.58L.0312211235010.6632@logos.cnet> <20031221184709.GO25043@ovh.net> <20031221185959.GE1494@louise.pinerecords.com> <20031221234350.GD4897@ovh.net> <Pine.LNX.4.58L.0312220921120.2691@logos.cnet> <20031222123036.GW12491@ovh.net> <20031222151724.GB18767@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20031222151724.GB18767@dualathlon.random>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> your softdog is too strict for the workload you're running. You can't
> pretend a low latency scheduling behaviour with hundres oom. what you
> see is perfectly normal.

You are right. I can see oom killer's work without watchdog. It takes
1 hour before all bad process are killed, since oom kills first the
process with shared memory (named, httpd, mysql etc), then the bad
process. I think it's the right way for general used.

Thanks
Octave

