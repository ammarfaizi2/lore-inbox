Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751209AbWH0ACS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbWH0ACS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 20:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbWH0ACS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 20:02:18 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:53201
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751209AbWH0ACR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 20:02:17 -0400
Date: Sat, 26 Aug 2006 17:02:24 -0700 (PDT)
Message-Id: <20060826.170224.110013012.davem@davemloft.net>
To: jeffm@suse.com
Cc: jengelh@linux01.gwdg.de, linux-kernel@vger.kernel.org, akpm@osdl.org,
       torvalds@osdl.org
Subject: Re: [PATCH] sun disk label: fix signed int usage for sector count
From: David Miller <davem@davemloft.net>
In-Reply-To: <44F070A6.5070209@suse.com>
References: <44EF1FAA.7000108@suse.com>
	<Pine.LNX.4.61.0608260931070.25807@yvahk01.tjqt.qr>
	<44F070A6.5070209@suse.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Mahoney <jeffm@suse.com>
Date: Sat, 26 Aug 2006 12:02:46 -0400

> You're right. The Solaris side of things treats this as signed.

I see no reason to disallow this and use an unsigned quantity.

