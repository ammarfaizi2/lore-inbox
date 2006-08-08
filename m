Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964988AbWHHQta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964988AbWHHQta (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 12:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964996AbWHHQt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 12:49:29 -0400
Received: from gateway-1237.mvista.com ([63.81.120.155]:51403 "EHLO
	imap.sh.mvista.com") by vger.kernel.org with ESMTP id S964988AbWHHQt3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 12:49:29 -0400
Message-ID: <44D8C0E0.9070800@ru.mvista.com>
Date: Tue, 08 Aug 2006 20:50:40 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: linux-mtd@lists.infradead.org, tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: [MTD] NAND: Fix ams-delta after core conversion
References: <20060808153944.GA8126@earth.li>
In-Reply-To: <20060808153944.GA8126@earth.li>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Jonathan McDowell wrote:

> The recent hwctrl core conversion for MTD NAND devices broke the Amstrad
> Delta driver. This fixes it up and uses the existing control line
> defines rather than unclear magic numbers.

    Ugh, au1550nd.c also looks broken by this change. No time to fix now though...

WBR, Sergei
