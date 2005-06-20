Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261328AbVFTClS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbVFTClS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 22:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261330AbVFTClR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 22:41:17 -0400
Received: from mail.dvmed.net ([216.237.124.58]:61079 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261328AbVFTClI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 22:41:08 -0400
Message-ID: <42B62CC0.3050401@pobox.com>
Date: Sun, 19 Jun 2005 22:41:04 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcel Naziri <silent@zwobbl.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: sata_promise KERNEL_BUG on 2.6.12
References: <200506200402.55229.silent@zwobbl.de> <42B62901.3000500@pobox.com> <200506200438.01602.silent@zwobbl.de>
In-Reply-To: <200506200438.01602.silent@zwobbl.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcel Naziri wrote:
> Could the driver "remap" it? It's confusing that the boot loader sees the 
> drives in another way than the kernel do.


Unfortunately it largely depends on how the board maker decided to wire 
up the ports.  If the Promise driver gets it right, I probably need to 
poke into BIOS somewhere...

	Jeff


