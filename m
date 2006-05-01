Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932115AbWEAN6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbWEAN6x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 09:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbWEAN6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 09:58:53 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:3750 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932115AbWEAN6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 09:58:52 -0400
Subject: Re: [RFC: 2.6 patch] drivers/char/applicom.c: proper
	module_{init,exit}
From: David Woodhouse <dwmw2@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060501071132.GG3570@stusta.de>
References: <20060501071132.GG3570@stusta.de>
Content-Type: text/plain
Date: Mon, 01 May 2006 14:58:50 +0100
Message-Id: <1146491930.2885.101.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-01 at 09:11 +0200, Adrian Bunk wrote:
> - converts the driver to use module_{init,exit}

Ack.

> - let the driver print a warning if the old __setup is used
> +       printk(KERN_WARNING "applicom= is deprecated\n  please use applicom.irq= and applicom.mem=\n");

I wouldn't bother with this -- just change it.

-- 
dwmw2

