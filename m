Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbWJGOlN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbWJGOlN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 10:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbWJGOlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 10:41:13 -0400
Received: from mail5.postech.ac.kr ([141.223.1.113]:36290 "EHLO
	mail5.postech.ac.kr") by vger.kernel.org with ESMTP id S932105AbWJGOlM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 10:41:12 -0400
Date: Sat, 7 Oct 2006 23:41:39 +0900
From: Seongsu Lee <senux@senux.com>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@xenotime.net>, Valdis.Kletnieks@vt.edu
Subject: Re: specifying the order of calling kernel functions (or modules)
Message-ID: <20061007144139.GA2155@pooky.senux.com>
References: <20060928101724.GA18635@pooky.senux.com> <200609281547.k8SFl3Au004978@turing-police.cc.vt.edu> <20060930104205.GB10248@pooky.senux.com> <20060930094731.2fe41e12.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060930094731.2fe41e12.rdunlap@xenotime.net>
X-TERRACE-SPAMMARK: NO       (SR:6.89)                     
  (by Terrace)                                                   
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Thank you for the replys.

I try to phrase differently.

I made a simple kernel module that do 'hello world'. The module will be
called when I do 'modprobe' or 'insmod' to load it into the memory.

When is the function, init_module(), in the module called in the case 
the module is compiled as a built-in one? (Not M but Y in .config)
Can I specify the exact time of calling the function, init_module() in
the module?

-- 
Seongsu Lee - http://www.senux.com/
The nice thing about Windows is - It does not just
crash, it displays a dialog box and lets you press
'OK' first. (Arno Schaefer's .sig)




