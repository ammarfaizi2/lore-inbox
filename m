Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266221AbUIMH1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266221AbUIMH1J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 03:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266257AbUIMH1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 03:27:09 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:47269 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266221AbUIMH1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 03:27:07 -0400
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrea Arcangeli <andrea@novell.com>, Chris Wedgwood <cw@f00f.org>,
       Arjan van de Ven <arjanv@redhat.com>, Hugh Dickins <hugh@veritas.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       LKML <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
In-Reply-To: <20040913061641.GA11276@elte.hu>
References: <20040910151538.GA24434@devserv.devel.redhat.com>
	 <20040910152852.GC15643@x30.random>
	 <20040910153421.GD24434@devserv.devel.redhat.com>
	 <1095016687.1306.667.camel@krustophenia.net>
	 <20040912192515.GA8165@taniwha.stupidest.org>
	 <20040912193542.GB28791@elte.hu> <20040912203308.GA3049@dualathlon.random>
	 <1095025000.22893.52.camel@krustophenia.net>
	 <20040912220720.GC3049@dualathlon.random>
	 <1095027951.22893.69.camel@krustophenia.net>
	 <20040913061641.GA11276@elte.hu>
Content-Type: text/plain
Message-Id: <1095060436.1857.8.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 13 Sep 2004 03:27:16 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-09-13 at 02:16, Ingo Molnar wrote:
> For servers and normal desktops the current IRQ and softirq
> model is pretty OK.
> 

Agreed.  I was just pointing out that it's not safe to assume that all
hardirq handlers execute quickly.  This doesn't seem to be a problem for
normal workloads.

Lee

