Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266267AbUBLE1Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 23:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266268AbUBLE1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 23:27:23 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:27058 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S266267AbUBLE1W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 23:27:22 -0500
To: Bongani Hlope <bonganilinux@mweb.co.za>
Cc: Mark de Vries <m.devries@nl.tiscali.com>, linux-kernel@vger.kernel.org
Subject: Re: About highmem in 2.6
References: <1o6EZ-2zO-27@gated-at.bofh.it> <1o7AZ-3PD-9@gated-at.bofh.it>
	<402A7EC6.7010003@nl.tiscali.com>
	<20040211212858.2ce1a17d.bonganilinux@mweb.co.za>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Thu, 12 Feb 2004 05:02:53 +0100
In-Reply-To: <20040211212858.2ce1a17d.bonganilinux@mweb.co.za> (Bongani
 Hlope's message of "Wed, 11 Feb 2004 21:28:58 +0200")
Message-ID: <m3isidkkr6.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bongani Hlope <bonganilinux@mweb.co.za> writes:

> There is nothing wrong with that patch, the problem with Highmem support
> on x86 is that is uses an Intel hack to address the full 1Gb of memory,
> which make memory access a bit slower. The question is, does the 128Mb
> additional memory worth that penalty?

2GB/2GB split doesn't use any Intel hack nor highmem. In fact for
1 GB of RAM I use a little different split which covers the whole RAM
and gives more virtual RAM, something like 1.2/2.8 GB.
-- 
Krzysztof Halasa, B*FH
