Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268224AbUIBL2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268224AbUIBL2Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 07:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268214AbUIBL2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 07:28:16 -0400
Received: from mx2.elte.hu ([157.181.151.9]:61829 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S268224AbUIBL1w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 07:27:52 -0400
Date: Thu, 2 Sep 2004 13:28:56 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q6 - network is no longer smooth
Message-ID: <20040902112856.GA5377@elte.hu>
References: <OF04883085.9C3535D2-ON86256F00.0065652B@raytheon.com> <20040830192131.GA12249@elte.hu> <4135C12B.6050208@fr.thalesgroup.com> <20040901130518.GA10060@elte.hu> <413702EE.2000309@fr.thalesgroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <413702EE.2000309@fr.thalesgroup.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* P.O. Gaillard <pierre-olivier.gaillard@fr.thalesgroup.com> wrote:

> Hello,
> 
> I just tried with Q6 and the network behaviour seems odd :
>  - my ssh connection freezes a bit,
>  - communication between the two PCs sharing the GigE connection is 
>  difficult to start :

please try the -Q9 patch i just released, and if you still see any
problems does the following:

    echo 300 > /proc/sys/net/core/netdev_backlog_granularity

help?

	Ingo
