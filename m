Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261296AbVATXel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbVATXel (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 18:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261427AbVATXek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 18:34:40 -0500
Received: from fw.osdl.org ([65.172.181.6]:52673 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261296AbVATXeh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 18:34:37 -0500
Date: Thu, 20 Jan 2005 15:39:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org, ajoshi@shell.unixbox.com,
       linux-fbdev-devel@lists.sourceforge.net,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Radeon framebuffer weirdness in -mm2
Message-Id: <20050120153921.11d7c4fa.akpm@osdl.org>
In-Reply-To: <20050120232122.GF3867@waste.org>
References: <20050120232122.GF3867@waste.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> wrote:
>
> I'm seeing radeonfb on my ThinkPad T30 go weird on reboot (lots of
> horizontal lines) and require powercycling to fix. Worked fine with 2.6.10.

Which radeon driver? CONFIG_FB_RADEON_OLD or CONFIG_FB_RADEON?

(cc Ben, who is the likely cuprit ;)

Which -mm2, btw?  2.6.10-mm2 or 2.6.11-rc1-mm2?

Did you try the corresponding -mm1?
