Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbUA0D32 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 22:29:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbUA0D32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 22:29:28 -0500
Received: from fw.osdl.org ([65.172.181.6]:30104 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261522AbUA0D31 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 22:29:27 -0500
Date: Mon, 26 Jan 2004 19:28:40 -0800
From: Andrew Morton <akpm@osdl.org>
To: jim.houston@comcast.net
Cc: ak@suse.de, george@mvista.com, amitkale@emsyssoft.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kgdb-x86_64-support.patch for 2.6.2-rc1-mm3
Message-Id: <20040126192840.0c1694b9.akpm@osdl.org>
In-Reply-To: <20040127030529.8F860C60FC@h00e098094f32.ne.client2.attbi.com>
References: <20040127030529.8F860C60FC@h00e098094f32.ne.client2.attbi.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Houston <jim.houston@comcast.net> wrote:
>
> The attached patch updates my kgdb-x86_64-support.patch to work
>  with linux-2.6.2-rc1-mm3.

Thanks.  Why does it relocate the call to trap_init() in start_kernel()?
