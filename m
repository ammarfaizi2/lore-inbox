Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265951AbUFOU4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265951AbUFOU4F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 16:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265947AbUFOU4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 16:56:05 -0400
Received: from h001061b078fa.ne.client2.attbi.com ([24.91.86.110]:49038 "EHLO
	linuxfarms.com") by vger.kernel.org with ESMTP id S265951AbUFOU4B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 16:56:01 -0400
Date: Tue, 15 Jun 2004 16:56:20 -0400 (EDT)
From: Arthur Perry <kernel@linuxfarms.com>
X-X-Sender: kernel@tiamat.perryconsulting.net
To: linux-kernel@vger.kernel.org
Subject: PCI bandwidth measurement methods
Message-ID: <Pine.LNX.4.58.0406151429200.30923@tiamat.perryconsulting.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a question about methods of measuring PCI-X bandwidth.
I was wondering if anybody has any ideas.
What I am looking for is an "industry standard" method, if one exists.
At this point, such software does not exist in SPEC.
Different HBA cards such as Myricom and Mellanox (Myrinet and Infiniband
hosts) have utilitites to test your PCI bandwidth..
But what do you do when they come up with completely different numbers?

What I need is an unbiased, objective PCI-X bandwidth test.
It's all about performance in Linux actually... So I can't say "completely
objective"..

I can write software that will do this, possibly by performing PCI
writes to scratch memory area on several different HBAs..
Or maybe adding a counter into the Linux PCI device driver to verify the
bandwidth claims that Mellanox and Myricom's tools report.
But before I re-invent the wheel, I was wondering if anybody knew of anything that is already out there.
If I were to write something, a whole software validation process would
have to be performed on top of the actual work.
If anybody knows of something that already exists and has been in use, it would be ideal.


Thanks!



