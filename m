Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264207AbTEGShR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 14:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264209AbTEGShR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 14:37:17 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:43946 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S264207AbTEGShQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 14:37:16 -0400
X-AuthUser: davidel@xmailserver.org
Date: Wed, 7 May 2003 11:51:19 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: top stack (l)users for 2.5.69
In-Reply-To: <Pine.LNX.4.53.0305071424290.13499@chaos>
Message-ID: <Pine.LNX.4.50.0305071137330.2208-100000@blue1.dev.mcafeelabs.com>
References: <20030507132024.GB18177@wohnheim.fh-wedel.de>
 <Pine.LNX.4.53.0305070933450.11740@chaos> <20030507135657.GC18177@wohnheim.fh-wedel.de>
 <Pine.LNX.4.53.0305071008080.11871@chaos> <p05210601badeeb31916c@[207.213.214.37]>
 <Pine.LNX.4.53.0305071323100.13049@chaos> <52k7d2pqwm.fsf@topspin.com>
 <Pine.LNX.4.53.0305071424290.13499@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 May 2003, Richard B. Johnson wrote:

> No, No. That is a process stack. Every process has it's own, entirely
> seperate stack. This stack is used only in user mode. The kernel has
> it's own stack. Every time you switch to kernel mode either by
> calling the kernel or by a hardware interrupt, the kernel's stack
> is used.

Is it your understanding that does not exist a per task kernel stack ?



- Davide

