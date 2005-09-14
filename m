Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965044AbVINGaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965044AbVINGaP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 02:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965045AbVINGaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 02:30:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54448 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965044AbVINGaN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 02:30:13 -0400
Date: Tue, 13 Sep 2005 23:29:44 -0700
From: Chris Wright <chrisw@osdl.org>
To: Horms <horms@verge.net.au>
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org,
       stable@kernel.org, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, micha@debian.org
Subject: Re: [patch 04/09] x86_64: avoid SMP boot up race
Message-ID: <20050914062943.GP7762@shell0.pdx.osdl.net>
References: <20050608234637.GG13152@shell0.pdx.osdl.net> <20050609000408.GK13152@shell0.pdx.osdl.net> <20050914031356.GA19160@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050914031356.GA19160@verge.net.au>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Horms (horms@verge.net.au) wrote:
> I'm wondering if anyone could comment on if this could
> be conceived as a security bug. My initial instinct was
> yes, but on further considertation I can't conceive
> a way it could be exploited, well not by anyone
> who couldn't DoS the box in any number of other ways,
> including shutting it down.

That code is run early during boot up when bringing online a cpu.
If you can control this, you own the box.
