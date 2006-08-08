Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030194AbWHHQ7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030194AbWHHQ7Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 12:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964999AbWHHQ7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 12:59:23 -0400
Received: from gateway-1237.mvista.com ([63.81.120.155]:64203 "EHLO
	imap.sh.mvista.com") by vger.kernel.org with ESMTP id S964903AbWHHQ7W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 12:59:22 -0400
Message-ID: <44D8C331.8080800@ru.mvista.com>
Date: Tue, 08 Aug 2006 21:00:33 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>, tglx@linutronix.de
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [MTD] NAND: Fix ams-delta after core conversion
References: <20060808153944.GA8126@earth.li> <44D8C0E0.9070800@ru.mvista.com>
In-Reply-To: <44D8C0E0.9070800@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Sergei Shtylyov wrote:

>>The recent hwctrl core conversion for MTD NAND devices broke the Amstrad
>>Delta driver. This fixes it up and uses the existing control line
>>defines rather than unclear magic numbers.

>     Ugh, au1550nd.c also looks broken by this change. No time to fix now though...

   OTOH, it was too hasty conclusion. This driver overrides both select_chip 
and cmdfunc, so probably not. I'll try it somewhat later for real...

WBR, Sergei
