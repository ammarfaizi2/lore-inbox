Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264563AbTLQVmO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 16:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264565AbTLQVmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 16:42:14 -0500
Received: from mail2.bluewin.ch ([195.186.4.73]:45783 "EHLO mail2.bluewin.ch")
	by vger.kernel.org with ESMTP id S264563AbTLQVmL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 16:42:11 -0500
Date: Wed, 17 Dec 2003 22:41:08 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>, wli@holomorphy.com,
       kernel@kolivas.org, chris@cvine.freeserve.co.uk,
       linux-kernel@vger.kernel.org, mbligh@aracnet.com
Subject: Re: 2.6.0-test9 - poor swap performance on low end machines
Message-ID: <20031217214107.GA3650@k3.hellgate.ch>
Mail-Followup-To: Rik van Riel <riel@redhat.com>,
	Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
	wli@holomorphy.com, kernel@kolivas.org, chris@cvine.freeserve.co.uk,
	linux-kernel@vger.kernel.org, mbligh@aracnet.com
References: <20031216112307.GA5041@k3.hellgate.ch> <Pine.LNX.4.44.0312171351080.28701-100000@chimarrao.boston.redhat.com> <20031217194950.GA9375@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031217194950.GA9375@k3.hellgate.ch>
X-Operating-System: Linux 2.6.0-test11 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Dec 2003 20:49:51 +0100, Roger Luethi wrote:
> right now just to make sure. It's going to take a couple of hours,
> I'll follow up with results.

For efax, a benchmark run with mem=32M, the difference in run time
between values 256 and 1024 for /proc/sys/vm/min_free_kbytes is noise
(< 1%).

Roger
