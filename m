Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932623AbWG1LOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932623AbWG1LOA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 07:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbWG1LOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 07:14:00 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:1998
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751079AbWG1LN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 07:13:59 -0400
Date: Fri, 28 Jul 2006 04:13:59 -0700 (PDT)
Message-Id: <20060728.041359.68038076.davem@davemloft.net>
To: mikpe@it.uu.se
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [BUG sparc64] 2.6.16-git6 broke X11 on Ultra5 with ATI Mach64
From: David Miller <davem@davemloft.net>
In-Reply-To: <200607281035.k6SAZOJ3015670@harpo.it.uu.se>
References: <200607281035.k6SAZOJ3015670@harpo.it.uu.se>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikael Pettersson <mikpe@it.uu.se>
Date: Fri, 28 Jul 2006 12:35:24 +0200 (MEST)

> FAULT: write(1) old_entry[e00001ffe1970f8a]
> FAULT: After, entry[e00001ffe1970f8a]
> 
> The last two lines then repeat semi-infinitely, and they
> were generated at an extremely high rate.

Thanks, this should help me find the bug.
