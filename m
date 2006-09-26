Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751479AbWIZFo0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbWIZFo0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 01:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751530AbWIZFoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 01:44:05 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:54648 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751479AbWIZFks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 01:40:48 -0400
Date: Tue, 26 Sep 2006 08:40:45 +0300
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] trident oss: Switch to newer API also fix a bug
Message-ID: <20060926054045.GC20797@rhun.haifa.ibm.com>
References: <1159224583.11049.173.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159224583.11049.173.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2006 at 11:49:43PM +0100, Alan Cox wrote:

> The old driver erroneously passed pdev not NULL to a second search. This
> happened to always work except with pci=reverse because of chip
> ordering.

[please CC me on trident patches]

/home/muli/kernel/trident/trident.hg/sound/oss/trident.c: In function `ali_reset_5451':
/home/muli/kernel/trident/trident.hg/sound/oss/trident.c:4128: `pdev' undeclared (first use in this function)
/home/muli/kernel/trident/trident.hg/sound/oss/trident.c:4128: (Each undeclared identifier is reported only once
/home/muli/kernel/trident/trident.hg/sound/oss/trident.c:4128: for each function it appears in.)

I'll fix it up and resubmit. Thanks for the patch!

Cheers,
Muli
