Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268347AbUIPXIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268347AbUIPXIg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 19:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268314AbUIPXHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 19:07:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:30903 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268305AbUIPXFX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 19:05:23 -0400
Date: Thu, 16 Sep 2004 16:08:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: hunold-ml@web.de, c.pascoe@itee.uq.edu.au, jelle@foks.8m.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] v4l/dvb: cx88 driver update
Message-Id: <20040916160835.4a6cea02.akpm@osdl.org>
In-Reply-To: <20040916094323.GA11601@bytesex>
References: <20040916094323.GA11601@bytesex>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerd Knorr <kraxel@bytesex.org> wrote:
>
> 
> This is a major update of the cx88 driver.

drivers/media/video/cx88/cx88-dvb.c:215: `FE_UNREGISTER' undeclared (first use in this function)
drivers/media/video/cx88/cx88-dvb.c:215: (Each undeclared identifier is reported only once
drivers/media/video/cx88/cx88-dvb.c:215: for each function it appears in.)
drivers/media/video/cx88/cx88-dvb.c: In function `dvb_register':
drivers/media/video/cx88/cx88-dvb.c:232: `FE_REGISTER' undeclared (first use in this function)
drivers/media/video/cx88/cx88-dvb.c:294: `FE_UNREGISTER' undeclared (first use in this function)

I'll drop this one - please wholly resend it.
