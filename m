Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271630AbTGQX3X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 19:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271634AbTGQX3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 19:29:23 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:22466 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S271630AbTGQX3G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 19:29:06 -0400
X-AuthUser: davidel@xmailserver.org
Date: Thu, 17 Jul 2003 16:36:42 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: asm (lidt) question
In-Reply-To: <20030717163103.40d4c96e.rddunlap@osdl.org>
Message-ID: <Pine.LNX.4.55.0307171634380.4845@bigblue.dev.mcafeelabs.com>
References: <20030717152819.66cfdbaf.rddunlap@osdl.org>
 <Pine.LNX.4.55.0307171535020.4845@bigblue.dev.mcafeelabs.com>
 <Pine.LNX.4.55.0307171615580.4845@bigblue.dev.mcafeelabs.com>
 <20030717163103.40d4c96e.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jul 2003, Randy.Dunlap wrote:

> | Randy, I'd say that this :
> |
> | __asm__ __volatile__("lidt %0": "=m" (var));
> |
> | is better then :
> |
> | __asm__ __volatile__("lidt %0": :"m" (var));
> |
> | IMHO, since "var" is really an output parameter.
>
> Yes, I agree, var is output and should be listed after the first ':'
> IMHO also.

BF (Brain Farting) is contagious ;) I need a vacation, a long one (and you
too so maybe OSDL will hire someone else meanwhile :)



- Davide

