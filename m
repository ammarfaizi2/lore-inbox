Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263661AbTKFPbe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 10:31:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263666AbTKFPbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 10:31:34 -0500
Received: from pingviini.net ([194.29.194.26]:22796 "HELO hinku.pingviini.net")
	by vger.kernel.org with SMTP id S263661AbTKFPb2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 10:31:28 -0500
Date: Thu, 6 Nov 2003 17:31:24 +0200
From: Niklas Vainio <niklas.vainio@iki.fi>
To: linux-kernel@vger.kernel.org
Cc: Mikael Pettersson <mikpe@csd.uu.se>
Subject: Re: [RFC][PATCH][2.6] CONFIG_HZ for x86
Message-ID: <20031106153124.GB31084@vinku.pingviini.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <NsuO.64F.21@gated-at.bofh.it>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson:
>This patch adds a CONFIG_HZ option to x86, allowing the kernel-
>internal HZ to be reduced from 1000 to 512 or 100. This solves
>lost timer interrupt problems on really old machines like my 486.
>According to Alan Cox, HZ==1000 is also harmful on some laptops
>(presumably due to long SMI windows), so this patch should be
>useful for those too.

I'm not sure if I had the same problem, but my system clock wasn't
staying in time. This patch solved the problem. This is a Pentium III
desktop machine so it looks like other machines are affected too.

    - Nikke
