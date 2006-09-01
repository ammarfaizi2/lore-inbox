Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964858AbWIAGRL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964858AbWIAGRL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 02:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964867AbWIAGRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 02:17:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48109 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964858AbWIAGRK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 02:17:10 -0400
Date: Thu, 31 Aug 2006 23:17:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: NeilBrown <neilb@suse.de>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Olaf Kirch <okir@suse.de>
Subject: Re: [PATCH 004 of 19] knfsd: lockd: introduce nsm_handle
Message-Id: <20060831231703.78c99b60.akpm@osdl.org>
In-Reply-To: <1060901043825.27464@suse.de>
References: <20060901141639.27206.patches@notabene>
	<1060901043825.27464@suse.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Sep 2006 14:38:25 +1000
NeilBrown <neilb@suse.de> wrote:

> +static DECLARE_MUTEX(nsm_sema);
> ...
> +	down(&nsm_sema);

Next you'll all be wearing bell-bottomed jeans?
