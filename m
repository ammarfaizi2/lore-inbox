Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263384AbTIBAbs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 20:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263385AbTIBAbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 20:31:48 -0400
Received: from mta03.fuse.net ([216.68.1.123]:14490 "EHLO mta03.fuse.net")
	by vger.kernel.org with ESMTP id S263384AbTIBAbr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 20:31:47 -0400
From: "Dale E Martin" <dmartin@cliftonlabs.com>
Date: Mon, 1 Sep 2003 20:31:46 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: repeatable, hard lockup on boot in linux-2.6.0-test4 (more details)
Message-ID: <20030902003146.GA870@cliftonlabs.com>
References: <20030901195706.GA853@cliftonlabs.com> <20030901152809.0311f46f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030901152809.0311f46f.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> OK, don't go away yet ;)
> 
> Could you please add this patch and see how far it gets?  If you're keen,
> keep adding more DB() statements, narrow it down further?

It made it to line 853, and the loop ran four times.  No other "DB" ever
printed anything, so I guess it locked up inside i8042_init_mux_values when
i = 3.

Thanks again for the help,
	Dale
-- 
Dale E. Martin, Clifton Labs, Inc.
Senior Computer Engineer
dmartin@cliftonlabs.com
http://www.cliftonlabs.com
pgp key available
