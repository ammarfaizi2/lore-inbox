Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268336AbUJJQb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268336AbUJJQb6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 12:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268339AbUJJQb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 12:31:58 -0400
Received: from waste.org ([209.173.204.2]:11920 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S268336AbUJJQb5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 12:31:57 -0400
Date: Sun, 10 Oct 2004 11:31:53 -0500
From: Matt Mackall <mpm@selenic.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] __initdata strings
Message-ID: <20041010163153.GJ31237@waste.org>
References: <4169551D.A884778D@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4169551D.A884778D@tv-sign.ru>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 10, 2004 at 07:28:29PM +0400, Oleg Nesterov wrote:
> Hello.
> 
> This patch is not intended for inclusion, just for illustration.
> 
> __init functions leaves strings (mainly printk's arguments) in
> .data section. It make sense to move them in .init.data.

Probably better to do this with something like objcopy?

-- 
Mathematics is the supreme nostalgia of our time.
