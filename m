Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261660AbUKQSoz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbUKQSoz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 13:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262491AbUKQSmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 13:42:40 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:20949 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262417AbUKQSkN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 13:40:13 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Wed, 17 Nov 2004 19:22:28 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: jelle@foks.8m.com, lkml <linux-kernel@vger.kernel.org>,
       akpm <akpm@osdl.org>
Subject: Re: [PATCH] cx88: fix printk arg. type
Message-ID: <20041117182228.GL8176@bytesex>
References: <419A89A3.90903@osdl.org> <20041117172519.GB8176@bytesex> <419B8EC0.2070005@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <419B8EC0.2070005@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> C99 spec defines 'z' only as a size_t format length modifier:

Thanks.

> Anyway, I agree with Al.  Will you please change it to
> 'z' instead of 'Z'?

Done.

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)
