Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263024AbTKJI04 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 03:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263051AbTKJI04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 03:26:56 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:9164 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S263024AbTKJI0y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 03:26:54 -0500
To: Sylvain Jeaugey <sylvain.jeaugey@bull.net>
Cc: Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org,
       <linux-ia64@vger.kernel.org>, <acpi-devel@lists.sourceforge.net>
Subject: Re: [DMESG] cpumask_t in action
References: <Pine.LNX.4.44.0311070907020.29453-100000@localhost.localdomain>
From: Jes Sorensen <jes@wildopensource.com>
Date: 10 Nov 2003 03:26:50 -0500
In-Reply-To: <Pine.LNX.4.44.0311070907020.29453-100000@localhost.localdomain>
Message-ID: <yq0brrky6gl.fsf@wildopensource.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Sylvain" == Sylvain Jeaugey <sylvain.jeaugey@bull.net> writes:

Sylvain> These lines show you the numa topology of your machine (in
Sylvain> our case, we have 2 CPUS per domain, and a memory area).
Sylvain> This is quite a big piece of information about hardware. Even
Sylvain> if it is quite long, I think it should be part of the ACPI
Sylvain> information.

Hi Sylvian,

This information is much better exposed through sysfs (/sys) and Andi
Kleen's libnuma, which will also make it visible at runtime to
applications.

Cheers,
Jes
