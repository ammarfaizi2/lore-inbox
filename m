Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932483AbWGAAeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932483AbWGAAeK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 20:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbWGAAeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 20:34:10 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:25802 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932083AbWGAAeI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 20:34:08 -0400
Message-ID: <44A5C2FC.9000908@garzik.org>
Date: Fri, 30 Jun 2006 20:34:04 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>, linux@dominikbrodowski.net,
       Netdev List <netdev@vger.kernel.org>,
       "John W. Linville" <linville@tuxdriver.com>
Subject: Re: [PATCH] pcmcia: hostap_cs.c - 0xc00f,0x0000 conflicts with pcnet_cs
References: <200607010001.k610165k008843@hera.kernel.org>
In-Reply-To: <200607010001.k610165k008843@hera.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> commit fd99ddd0701385344eadaf2daa6abbc5fb086750
> tree 013d75048f086edfa7a89ac3f3301dde13017817
> parent 0db6095d4ff8918350797dfe299d572980e82fa0
> author Komuro <komurojun-mbn@nifty.com> Mon, 17 Apr 2006 21:41:21 +0900
> committer Dominik Brodowski <linux@dominikbrodowski.net> Fri, 30 Jun 2006 22:09:12 +0200
> 
> [PATCH] pcmcia: hostap_cs.c - 0xc00f,0x0000 conflicts with pcnet_cs
> 
> Comment out the ID 0xc00f,0x0000 in hostap_cs.c, as it conflicts with the
> pcnet_cs driver.
> 
> Signed-off-by: komurojun-mbn@nifty.com
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
> 
>  drivers/net/wireless/hostap/hostap_cs.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)

drivers/net/wireless stuff should go through netdev and John Linville.

I'm going to go out on a limb, and guess that Linville never saw this patch?

	Jeff


