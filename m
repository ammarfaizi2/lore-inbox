Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261543AbUCBCAp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 21:00:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261544AbUCBCAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 21:00:45 -0500
Received: from fw.osdl.org ([65.172.181.6]:34502 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261543AbUCBCAp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 21:00:45 -0500
Date: Mon, 1 Mar 2004 18:02:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: Bernhard Rosenkraenzer <bero@arklinux.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.4-rc1-mm1 SND_FM801_TEA575X Kconfig error
Message-Id: <20040301180239.7f091882.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0403020237530.6219@dot.kde.org>
References: <Pine.LNX.4.58.0403020237530.6219@dot.kde.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernhard Rosenkraenzer <bero@arklinux.org> wrote:
>
> -config CONFIG_SND_FM801_TEA575X
> +config SND_FM801_TEA575X
>  	tristate "ForteMedia FM801 + TEA5757 tuner"
>  	depends on SND_FM801
>          select CONFIG_VIDEO_DEV

                  ^^^^^^

That's broken too.    I've sent a fix to Jaroslaw, thanks.
