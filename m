Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262925AbTLGNeb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 08:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264426AbTLGNeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 08:34:31 -0500
Received: from mx1.elte.hu ([157.181.1.137]:33436 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262925AbTLGNea (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 08:34:30 -0500
Date: Sun, 7 Dec 2003 14:34:28 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sched-HT-2.6.0-test11-A5
In-Reply-To: <Pine.LNX.4.58.0312061601400.1758@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.58.0312071433300.28463@earth>
References: <20031117021511.GA5682@averell><3FB83790.3060003@cyberone.com.au><20031117141548.GB1770@colin2.muc.de><Pine.LNX.4.56.0311171638140.29083@earth><20031118173607.GA88556@colin2.muc.de><Pine.LNX.4.56.0311181846360.23128@earth><20031118235710.GA10075@colin2.muc.de><3FBAF84B.3050203@cyberone.com.au><501330000.1069443756@flay><3FBF099F.8070403@cyberone.com.au><1010800000.1069532100@[10.10.2.4]><3FC01817.3090705@cyberone.com.au><3FC0A0C2.90800@cyberone.com.au><Pine.LNX.4.56.0311231300290.16152@earth>
 <1027750000.1069604762@[10.10.2.4]> <Pine.LNX.4.58.0312011102540.3323@earth>
 <392900000.1070737269@[10.10.2.4]> <Pine.LNX.4.58.0312061601400.1758@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 6 Dec 2003, Zwane Mwaikambo wrote:

> Ingo here is a patch to fix compilation on larger NR_CPUS, [...]

thanks.

> [...] i have also appended the oops Martin is probably seeing. Currently
> debugging it.

i've seen a similar crash once on a 2-way (4-way) HT box, so there some
startup race going on most likely.

	Ingo
