Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263653AbTKFPqW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 10:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263667AbTKFPqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 10:46:22 -0500
Received: from aun.it.uu.se ([130.238.12.36]:25331 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S263653AbTKFPqV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 10:46:21 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16298.27847.121152.618726@alkaid.it.uu.se>
Date: Thu, 6 Nov 2003 16:46:15 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Niklas Vainio <niklas.vainio@iki.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH][2.6] CONFIG_HZ for x86
In-Reply-To: <20031106153124.GB31084@vinku.pingviini.net>
References: <NsuO.64F.21@gated-at.bofh.it>
	<20031106153124.GB31084@vinku.pingviini.net>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Niklas Vainio writes:
 > Mikael Pettersson:
 > >This patch adds a CONFIG_HZ option to x86, allowing the kernel-
 > >internal HZ to be reduced from 1000 to 512 or 100. This solves
 > >lost timer interrupt problems on really old machines like my 486.
 > >According to Alan Cox, HZ==1000 is also harmful on some laptops
 > >(presumably due to long SMI windows), so this patch should be
 > >useful for those too.
 > 
 > I'm not sure if I had the same problem, but my system clock wasn't
 > staying in time. This patch solved the problem. This is a Pentium III
 > desktop machine so it looks like other machines are affected too.
 > 
 >     - Nikke

Glad to hear it helped. Thanks for the feedback.

/Mikael
