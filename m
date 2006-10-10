Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964982AbWJJFSL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964982AbWJJFSL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 01:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964985AbWJJFSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 01:18:10 -0400
Received: from gate.crashing.org ([63.228.1.57]:3025 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964982AbWJJFSJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 01:18:09 -0400
Subject: Re: 2.6.19-rc1: known regressions (v3)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20061010051019.GB3650@stusta.de>
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org>
	 <20061010051019.GB3650@stusta.de>
Content-Type: text/plain
Date: Tue, 10 Oct 2006 15:16:46 +1000
Message-Id: <1160457406.32237.108.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Subject    : sleep/wakeup on powerbooks apparently busted
> References : http://lkml.org/lkml/2006/10/5/13
> Submitter  : Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Handled-By : Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Status     : Benjamin will investigate

Could be a long standing problem with some powerpc platform drivers not
properly updated to Russel King changes from last year (still using
struct device_driver instead of struct platform_driver). A patch will be
sent to Linus shortly by Paulus which makes it work for us. More field
testing will be needed.

Ben.


