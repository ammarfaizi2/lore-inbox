Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263709AbUHSGAJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263709AbUHSGAJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 02:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265943AbUHSGAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 02:00:09 -0400
Received: from fmr01.intel.com ([192.55.52.18]:20878 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S263709AbUHSGAG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 02:00:06 -0400
Subject: Re: [patch] enums to clear suspend-state confusion
From: Len Brown <len.brown@intel.com>
To: Pavel Machek <pavel@suse.cz>
Cc: David Brownell <david-b@pacbell.net>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
In-Reply-To: <566B962EB122634D86E6EE29E83DD808182C3774@hdsmsx403.hd.intel.com>
References: <566B962EB122634D86E6EE29E83DD808182C3774@hdsmsx403.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1092895178.25911.194.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 19 Aug 2004 01:59:39 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel,
Can you provide an example where the enum patch
causes gcc to generate a warning for incorrect code?

When I drop the wrong enum into a function,
gcc seems to eat it just as happily as when
we used u32's.  Maybe I'm missing something.

thanks,
-Len


