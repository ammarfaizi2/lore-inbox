Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751303AbWJQQab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbWJQQab (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 12:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbWJQQaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 12:30:30 -0400
Received: from pfx2.jmh.fr ([194.153.89.55]:47579 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S1751298AbWJQQa3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 12:30:29 -0400
From: Eric Dumazet <dada1@cosmosbay.com>
To: John Philips <johnphilips42@yahoo.com>
Subject: Re: BUG: warning at kernel/softirq.c:141/local_bh_enable()
Date: Tue, 17 Oct 2006 18:30:29 +0200
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
References: <20061017145336.65223.qmail@web57803.mail.re3.yahoo.com>
In-Reply-To: <20061017145336.65223.qmail@web57803.mail.re3.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610171830.29823.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 October 2006 16:53, John Philips wrote:
> > Could you send us, once your machine is handling its typical load :
> >
> > lspci -v
> > ethtool -S eth6
> > tc -s -d qdisc
> > cat /proc/slabinfo
> > cat /proc/meminfo
>
> Eric,
>
> Here's the output of the commands you mentioned.  The box is handling a
> medium amount of load right now.  I set eth6 back to auto-negotiation, and
> haven't seen the kernel BUG messages for the past 1/2 hour.

OK, could you please send now :

ifconfig eth6
cat /proc/interrupts
