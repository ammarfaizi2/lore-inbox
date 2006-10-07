Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932247AbWJGP01@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbWJGP01 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 11:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbWJGP01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 11:26:27 -0400
Received: from xenotime.net ([66.160.160.81]:19896 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932247AbWJGP00 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 11:26:26 -0400
Date: Sat, 7 Oct 2006 08:27:52 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Seongsu Lee <senux@senux.com>
Cc: linux-kernel@vger.kernel.org, Valdis.Kletnieks@vt.edu
Subject: Re: specifying the order of calling kernel functions (or modules)
Message-Id: <20061007082752.6ff90517.rdunlap@xenotime.net>
In-Reply-To: <20061007144139.GA2155@pooky.senux.com>
References: <20060928101724.GA18635@pooky.senux.com>
	<200609281547.k8SFl3Au004978@turing-police.cc.vt.edu>
	<20060930104205.GB10248@pooky.senux.com>
	<20060930094731.2fe41e12.rdunlap@xenotime.net>
	<20061007144139.GA2155@pooky.senux.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Oct 2006 23:41:39 +0900 Seongsu Lee wrote:

> Hello,
> 
> Thank you for the replys.
> 
> I try to phrase differently.
> 
> I made a simple kernel module that do 'hello world'. The module will be
> called when I do 'modprobe' or 'insmod' to load it into the memory.
> 
> When is the function, init_module(), in the module called in the case 
> the module is compiled as a built-in one? (Not M but Y in .config)
> Can I specify the exact time of calling the function, init_module() in
> the module?

That depends on the order that it is listed in the (nested)
Makefiles.  Which sub-directory and Makefile will you use?

---
~Randy
