Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262569AbVCVIjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbVCVIjy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 03:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262564AbVCVIjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 03:39:48 -0500
Received: from ctv-217-147-43-176.init.lt ([217.147.43.176]:60849 "EHLO
	buakaw.homelinux.net") by vger.kernel.org with ESMTP
	id S262565AbVCVIjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 03:39:45 -0500
X-Antivirus-MYDOMAIN-Mail-From: buakaw@buakaw.homelinux.net via buakaw
X-Antivirus-MYDOMAIN: 1.22-st-qms (Clear:RC:1(127.0.0.1):. Processed in 0.622853 secs Process 15051)
Message-ID: <1297.192.168.0.37.1111480783.squirrel@buakaw.homelinux.net>
In-Reply-To: <20050321194022.491060c7.akpm@osdl.org>
References: <1144.192.168.0.37.1111351868.squirrel@buakaw.homelinux.net>
    <20050321194022.491060c7.akpm@osdl.org>
Date: Tue, 22 Mar 2005 10:39:43 +0200 (EET)
Subject: Re: dst cache overflow
From: buakaw@buakaw.homelinux.net
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.4
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


computer's main job is to be router on small LAN with 10 users and  some
services like qmail, apache, proftpd, shoutcast, squid, and ices on slack
10.1. Iptables and tc are used to limit  bandwiwdth and the two bandwidthd
 daemons are running on eth0 interface and all the time the cpu is used at
about 0.4% and additional 12% by ices  when encoding mp3 on demand, and
the proccess ksoftirqd/0 randomally starts to use 100% of 0 cpu in normal
situation and one time when the ksoftirqd/0 became crazy i noticed dst
cache overflow messages in syslog but there are more of thies lines in
logs  about 5 times in 10 days period

Could you please describe the workload?  What is the computer doing at the
 time, and how is it set up?

 Thanks.













