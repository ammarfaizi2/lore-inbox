Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261931AbVCNVZy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbVCNVZy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 16:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261946AbVCNVXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 16:23:52 -0500
Received: from news.cistron.nl ([62.216.30.38]:45190 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S261928AbVCNVXY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 16:23:24 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: Devices/Partitions over 2TB
Date: Mon, 14 Mar 2005 21:23:19 +0000 (UTC)
Organization: Cistron
Message-ID: <d14vc7$8cu$2@news.cistron.nl>
References: <200503141644.j2EGiVh0000022634@mudpuddle.cs.wustl.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1110835399 8606 194.109.0.112 (14 Mar 2005 21:23:19 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: mikevs@cistron.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200503141644.j2EGiVh0000022634@mudpuddle.cs.wustl.edu>,
Berkley Shands  <berkley@cs.wustl.edu> wrote:
>I have not found any documentation of efforts to overcome the 2TB
>partition limit,

config LBD
        bool "Support for Large Block Devices"
        depends on X86 || MIPS32 || PPC32 || ARCH_S390_31 || SUPERH
        help
          Say Y here if you want to attach large (bigger than 2TB) discs to
          your machine, or if you want to have a raid or loopback device
          bigger than 2TB.  Otherwise say N.

Mike.

