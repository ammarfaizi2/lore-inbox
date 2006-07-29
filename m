Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422699AbWG2IZW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422699AbWG2IZW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 04:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422700AbWG2IZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 04:25:21 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:35340 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1422699AbWG2IZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 04:25:21 -0400
Date: Sat, 29 Jul 2006 09:25:11 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 2/2] headers_check: fix #include regexp
Message-ID: <20060729082511.GB26956@flint.arm.linux.org.uk>
Mail-Followup-To: Alexey Dobriyan <adobriyan@gmail.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>
References: <20060729082249.GD6843@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060729082249.GD6843@martell.zuzino.mipt.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2006 at 12:22:49PM +0400, Alexey Dobriyan wrote:
> Note it's [SPACE TAB]*

Why not use [[:space:]] rather than [ 	] ?  It's hard to see what black
characters on a black background are actually trying to do.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
