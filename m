Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261955AbTIMSw2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 14:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261958AbTIMSw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 14:52:28 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:24989 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261955AbTIMSw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 14:52:27 -0400
Subject: Re: RFC: [2.6 patch] better i386 CPU selection
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Dave Jones <davej@redhat.com>, Adrian Bunk <bunk@fs.tum.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030913182159.GA10047@gtf.org>
References: <20030913125103.GE27368@fs.tum.de>
	 <20030913161149.GA1750@redhat.com>  <20030913182159.GA10047@gtf.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063478871.9064.3.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Sat, 13 Sep 2003 19:47:52 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-09-13 at 19:21, Jeff Garzik wrote:
> If you know that you're only booting on a 486, why include all the junk
> needed solely for later processors?

Because its a nightmare to provide a billion CPU specific kernels, a set
of foo and higher kernels and a "generic kernel", then do it for each
platform 2.6 supports for x86, then test it.

The submission already looks like something out of a puzzle book

