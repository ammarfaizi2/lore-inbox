Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932237AbVIGUCQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbVIGUCQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 16:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbVIGUCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 16:02:15 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:49541
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751289AbVIGUCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 16:02:14 -0400
Date: Wed, 07 Sep 2005 13:01:51 -0700 (PDT)
Message-Id: <20050907.130151.71544363.davem@davemloft.net>
To: netdev@axxeo.de
Cc: jgarzik@pobox.com, akpm@osdl.org, pavel@ucw.cz,
       ipw2100-admin@linux.intel.com, pavel@suse.cz,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [patch 1/1] ipw2100: remove by-hand function entry/exit
 debugging
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200509071539.08780.netdev@axxeo.de>
References: <20050906.194111.130652562.davem@davemloft.net>
	<431E5514.2070003@pobox.com>
	<200509071539.08780.netdev@axxeo.de>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Oeser <netdev@axxeo.de>
Date: Wed, 7 Sep 2005 15:39:08 +0200

> Jeff Garzik wrote:
> > I find them useful in my own drivers; they are definitely not pure noise.
> 
> gcc -finstrument-functions

I was going to mention this as well, and also the idea to
enable CONFIG_MCOUNT on a per-file basis.

We should never be doing by hand what can be automated.
