Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266190AbUA1XfO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 18:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266208AbUA1XfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 18:35:13 -0500
Received: from palrel10.hp.com ([156.153.255.245]:63650 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S266190AbUA1XfG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 18:35:06 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16408.18213.790850.66687@napali.hpl.hp.com>
Date: Wed, 28 Jan 2004 15:35:01 -0800
To: Andi Kleen <ak@suse.de>
Cc: davidm@hpl.hp.com, davidm@napali.hpl.hp.com, iod00d@hp.com,
       ishii.hironobu@jp.fujitsu.com, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [RFC/PATCH, 1/4] readX_check() performance evaluation
In-Reply-To: <20040128210132.2b0e5a96.ak@suse.de>
References: <00a201c3e541$c0e7d680$2987110a@lsd.css.fujitsu.com>
	<20040128172004.GB5494@cup.hp.com>
	<20040128184137.616b6425.ak@suse.de>
	<16408.30.896895.980121@napali.hpl.hp.com>
	<20040128195246.47a84498.ak@suse.de>
	<16408.3157.336306.812481@napali.hpl.hp.com>
	<20040128203915.22d84e8d.ak@suse.de>
	<16408.4597.123125.788631@napali.hpl.hp.com>
	<20040128210132.2b0e5a96.ak@suse.de>
X-Mailer: VM 7.17 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 28 Jan 2004 21:01:32 +0100, Andi Kleen <ak@suse.de> said:

  Andi> Seriously you can count it somewhere and present it in sysfs
  Andi> or /proc.  Or log it somewhere else and supply a special
  Andi> utility to show them that makes it clear that the events are
  Andi> hardware and not software related.  I suppose if your server
  Andi> vendor is serious they will supply a tool to read the firmware
  Andi> log from a running system.

  Andi> But printks enabled by default are a bad idea (and a bug too
  Andi> BTW - printk called from MCE handlers can randomly deadlock)

No argument here.  I didn't get/see the earlier part of this
discussion so I didn't realize you were complaining about printks
only.  Never mind.

	--david
