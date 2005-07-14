Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261604AbVGNRKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbVGNRKr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 13:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261607AbVGNRKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 13:10:47 -0400
Received: from sentinel.ucr.edu ([138.23.226.228]:25677 "EHLO sentinel.ucr.edu")
	by vger.kernel.org with ESMTP id S261604AbVGNRKp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 13:10:45 -0400
Date: Thu, 14 Jul 2005 10:10:39 -0700
From: Paul Vander Griend <vandep01@student.ucr.edu>
Subject: Kernel Bug Report
To: linux-kernel@vger.kernel.org
Cc: ruschein@infomine.ucr.edu
Reply-To: vandep01@student.ucr.edu
X-Mailer: Mirapoint Webmail Direct 3.5.6-GR
MIME-Version: 1.0
Message-Id: <30a258ac.1bd5021b.81be400@smh.ucr.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Junkmail-Status: score=15/65, host=sentinel.ucr.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


System:
Motherboard = Tyan K8WE
Processor = 2x Opteron 250
Memory = 8GB ECC Registered

On all of the recent release candidates except for
2.6.13-rc2-git2 the kernel panics while booting. These
versions include 2.6.13-rc2-git* (* != 2 ) and 2.6.13-rc3.

I also want to mention that I am using gcc 3.3.5 on debian and
that during compilation there are 3 messages at the end that
say an assertion has failed IE (LD: assertion failed).

It looks like it panics during a mem_cpy but I know its
difficult to tell just by the output.

I get a code: f3 a4 c3 66 66 66 90 66 66 66 90 66 66 66 90 66

The problem appears very reproducable so I can provide more
information upon request.

My .config is avaible upon request.

-Paul
