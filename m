Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265676AbTFNNiH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 09:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265674AbTFNNgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 09:36:41 -0400
Received: from mrw.demon.co.uk ([194.222.96.226]:5760 "EHLO rebecca")
	by vger.kernel.org with ESMTP id S265672AbTFNNgZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 09:36:25 -0400
Content-Type: text/plain; charset=US-ASCII
From: Mark Watts <m.watts@mrw.demon.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: Xeon  processors &&Hyper-Threading
Date: Sat, 14 Jun 2003 14:50:11 +0100
User-Agent: KMail/1.4.3
References: <3EE9FDFA.6020803@mindspring.com> <Pine.LNX.4.53.0306131241330.5894@chaos>
In-Reply-To: <Pine.LNX.4.53.0306131241330.5894@chaos>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200306141450.11804.m.watts@mrw.demon.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You recompile the kernel for SMP as well as P4. If the motherboard
> hasn't disabled HT capabilities, you will take full advantage of
> the processor under Linux. Whatever "full advantage" means, is
> not absolute, but whatever it is, will be used to its fullest.
> Basically, if the code is I/O bound, you'll not see any difference.
> If the code is compute-intensive, you will.

I discovered that you need the 'CPU Enumeration' part of ACPI to be enabled 
otherwise the kernel only sees physical processors, not sibling HT processors 
- shouldnt this be selected automatically when you select SMP ?
