Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261823AbVATUZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbVATUZI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 15:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbVATUZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 15:25:08 -0500
Received: from fw.osdl.org ([65.172.181.6]:39842 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261823AbVATUYy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 15:24:54 -0500
Date: Thu, 20 Jan 2005 12:24:20 -0800
From: Andrew Morton <akpm@osdl.org>
To: Daniel Drake <dsd@gentoo.org>
Cc: helge.hafting@hist.no, rddunlap@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk, jhf@rivenstone.net,
       linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au,
       opengeometry@yahoo.ca
Subject: Re: [PATCH] Configurable delay before mounting root device
Message-Id: <20050120122420.05ed47cc.akpm@osdl.org>
In-Reply-To: <41F01ADA.60605@gentoo.org>
References: <20050114002352.5a038710.akpm@osdl.org>
	<20050116005930.GA2273@zion.rivenstone.net>
	<41EC7A60.9090707@gentoo.org>
	<20050118003413.GA26051@parcelfarce.linux.theplanet.co.uk>
	<41EC5207.3030003@osdl.org>
	<41ECC8AF.9020404@hist.no>
	<20050118004935.7bd4a099.akpm@osdl.org>
	<41F01ADA.60605@gentoo.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Drake <dsd@gentoo.org> wrote:
>
> +	if (root_delay) {
>  +		printk(KERN_INFO "Waiting %dsec before mounting root device...\n",
>  +		       root_delay);
>  +		ssleep(root_delay);
>  +	}

Totally sad, but it's hard to see how that could break anything.

You owe me an update to Documentation/kernel-parameters.txt ;)
