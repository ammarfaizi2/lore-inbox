Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751433AbWEOHqt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbWEOHqt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 03:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbWEOHqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 03:46:49 -0400
Received: from ookhoi.xs4all.nl ([213.84.114.66]:13203 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S1751433AbWEOHqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 03:46:49 -0400
Date: Mon, 15 May 2006 09:46:37 +0200
From: Sander <sander@humilis.net>
To: David Lang <dlang@digitalinsight.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Erik Mouw <erik@harddisk-recovery.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       Jason Schoonover <jasons@pioneer-pra.com>, linux-kernel@vger.kernel.org
Subject: Re: High load average on disk I/O on 2.6.17-rc3
Message-ID: <20060515074633.GA13061@favonius>
Reply-To: sander@humilis.net
References: <200605051010.19725.jasons@pioneer-pra.com> <20060507095039.089ad37c.akpm@osdl.org> <445F548A.703@mbligh.org> <1147100149.2888.37.camel@laptopd505.fenrus.org> <20060508152255.GF1875@harddisk-recovery.com> <1147102290.2888.41.camel@laptopd505.fenrus.org> <445FF714.4050803@yahoo.com.au> <1147149399.3198.10.camel@laptopd505.fenrus.org> <Pine.LNX.4.62.0605082143270.20330@qynat.qvtvafvgr.pbz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0605082143270.20330@qynat.qvtvafvgr.pbz>
X-Uptime: 08:26:46 up 6 days, 23:15, 34 users,  load average: 3.71, 3.40, 3.14
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang wrote (ao):
> P.S. I would love to be told that I'm just ignorant of how to monitor
> these things independantly. it would make my life much easier to learn
> how.

I use vmstat and top together to determine if a system is (too) busy or
not.

vmstat gives a good indication about the amount of disk IO (both regular
IO and swap), and top sorted by cpu or memory shows which processes are
responsible for the numbers.

You as a human can interpret what you see. I don't think software should
do anything with the load average, as it does not reflect the actual
usage of the hardware.

	With kind regards, Sander

-- 
Humilis IT Services and Solutions
http://www.humilis.net
