Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261721AbVGIUa4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261721AbVGIUa4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 16:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261722AbVGIUa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 16:30:56 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:3762 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S261721AbVGIUay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 16:30:54 -0400
Date: Sat, 9 Jul 2005 13:30:36 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: Lee Revell <rlrevell@joe-job.com>
Cc: akpm@osdl.org, arjan@infradead.org, azarah@nosferatu.za.org, cw@f00f.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, christoph@lameter.org
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Message-Id: <20050709133036.11e60a3c.rdunlap@xenotime.net>
In-Reply-To: <1120936561.6488.84.camel@mindpipe>
References: <200506231828.j5NISlCe020350@hera.kernel.org>
	<20050708214908.GA31225@taniwha.stupidest.org>
	<20050708145953.0b2d8030.akpm@osdl.org>
	<1120928891.17184.10.camel@lycan.lan>
	<1120932991.6488.64.camel@mindpipe>
	<1120933916.3176.57.camel@laptopd505.fenrus.org>
	<1120934163.6488.72.camel@mindpipe>
	<20050709121212.7539a048.akpm@osdl.org>
	<1120936561.6488.84.camel@mindpipe>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClamAntiVirus-Scanner: This mail is clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - chretien.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 09 Jul 2005 15:16:01 -0400 Lee Revell wrote:

| On Sat, 2005-07-09 at 12:12 -0700, Andrew Morton wrote:
| > Lee Revell <rlrevell@joe-job.com> wrote:
| > >
| > >  > This is not a userspace visible thing really with few exceptions, and
| > >  > well people can select the one they want, right?
| > > 
| > >  Then why not leave the default at 1000?
| > 
| > Because some machines exhibit appreciable latency in entering low power
| > state via ACPI, and 1000Hz reduces their battery life.  By about half,
| > iirc.
| > 
| 
| Then the owners of such machines can use HZ=250 and leave the default
| alone.  Why should everyone have to bear the cost?

indeed, why should everyone have to have 1000 timer interrupts per second?

---
~Randy
