Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261266AbVATX4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbVATX4k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 18:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbVATX4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 18:56:40 -0500
Received: from fw.osdl.org ([65.172.181.6]:39123 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261266AbVATX4j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 18:56:39 -0500
Date: Thu, 20 Jan 2005 16:01:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org, ajoshi@shell.unixbox.com,
       linux-fbdev-devel@lists.sourceforge.net, benh@kernel.crashing.org
Subject: Re: Radeon framebuffer weirdness in -mm2
Message-Id: <20050120160123.14f13ca6.akpm@osdl.org>
In-Reply-To: <20050120234844.GF12076@waste.org>
References: <20050120232122.GF3867@waste.org>
	<20050120153921.11d7c4fa.akpm@osdl.org>
	<20050120234844.GF12076@waste.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> wrote:
>
> > Which radeon driver? CONFIG_FB_RADEON_OLD or CONFIG_FB_RADEON?
> 
> FB_RADEON.

Ah, OK.  Likely culprits are

radeonfb-massive-update-of-pm-code.patch
radeonfb-build-fix.patch

