Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbVGaFRy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbVGaFRy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 01:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbVGaFRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 01:17:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52420 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261711AbVGaFRx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 01:17:53 -0400
Date: Sat, 30 Jul 2005 22:17:49 -0700
From: Chris Wright <chrisw@osdl.org>
To: blaisorblade@yahoo.it
Cc: stable@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [stable] [patch 1/1] sys_get_thread_area does not clear the returned argument
Message-ID: <20050731051749.GL19052@shell0.pdx.osdl.net>
References: <20050730190703.233BB843@zion.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050730190703.233BB843@zion.home.lan>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* blaisorblade@yahoo.it (blaisorblade@yahoo.it) wrote:
> 
> From: Blaisorblade <blaisorblade@yahoo.it>
> CC: <stable@kernel.org>
> 
> sys_get_thread_area does not memset to 0 its struct user_desc info before
> copying it to user space...  since sizeof(struct user_desc) is 16 while the
> actual datas which are filled are only 12 bytes + 9 bits (across the
> bitfields), there is a (small) information leak.
> 
> This was already committed to Linus' repository.

Thanks, queued to -stable.
-chris
