Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263943AbUCZFYI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 00:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263944AbUCZFYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 00:24:08 -0500
Received: from palrel12.hp.com ([156.153.255.237]:21442 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S263943AbUCZFYF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 00:24:05 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16483.48754.946636.475447@napali.hpl.hp.com>
Date: Thu, 25 Mar 2004 21:24:02 -0800
To: Matt Mackall <mpm@selenic.com>
Cc: davidm@hpl.hp.com, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Fw: potential /dev/urandom scalability improvement
In-Reply-To: <20040326051532.GA4754@waste.org>
References: <20040325141923.7080c6f0.akpm@osdl.org>
	<20040325224726.GB8366@waste.org>
	<16483.35656.864787.827149@napali.hpl.hp.com>
	<20040325180014.29e40b65.akpm@osdl.org>
	<20040326041926.GG8366@waste.org>
	<16483.46826.466847.77987@napali.hpl.hp.com>
	<20040326051532.GA4754@waste.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 25 Mar 2004 23:15:32 -0600, Matt Mackall <mpm@selenic.com> said:

  Matt> Ok, previous observation made no sense; I should really be taking a
  Matt> nap right now. Hopefully this next one will make more sense: it ought
  Matt> to be ____cacheline_aligned_in_smp as the zero-byte spinlock struct
  Matt> still forces alignment.

Makes tons of sense, agreed.

	--david
