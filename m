Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264934AbTLWDXy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 22:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264937AbTLWDXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 22:23:54 -0500
Received: from dp.samba.org ([66.70.73.150]:16006 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264934AbTLWDXx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 22:23:53 -0500
Date: Tue, 23 Dec 2003 13:53:26 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Christophe Saout <christophe@saout.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, clemens@endorphin.org,
       thornber@sistina.com
Subject: Re: [PATCH 2/2][RFC] Add dm-crypt target
Message-Id: <20031223135326.216883e5.rusty@rustcorp.com.au>
In-Reply-To: <20031222215236.GB13103@leto.cs.pocnet.net>
References: <1072129379.5570.73.camel@leto.cs.pocnet.net>
	<20031222215236.GB13103@leto.cs.pocnet.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Dec 2003 22:52:36 +0100
Christophe Saout <christophe@saout.de> wrote:

> Hi,

Hi Christophe!

	One anal comment:
> +/*
> + * module hooks
> + */
> +module_init(dm_crypt_init)
> +module_exit(dm_crypt_exit)

Please use semicolons here.  It's nicer C-looking, and it means we don't have
to do silly things in the macros.

Thanks,
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
