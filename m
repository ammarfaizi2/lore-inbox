Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267777AbUJOOWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267777AbUJOOWa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 10:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267798AbUJOOWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 10:22:30 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:14287 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267777AbUJOOW3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 10:22:29 -0400
Subject: Re: PCI IRQ problems: "nobody cared!"
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jim Paris <jim@jtan.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041015083722.GA3315@jim.sh>
References: <20041015083722.GA3315@jim.sh>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1097846385.9857.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 15 Oct 2004 14:19:46 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-10-15 at 09:37, Jim Paris wrote:
> Could someone who knows more than me about PCI IRQs take a quick look
> at those dumps and tell me if there's anything obvious that I'm
> missing, or some way to work around the problem?

I posted a patch to poll when we find IRQ's have gone astray. It needs
redoing versus Ingo's new 2.6.9 IRQ code but should apply cleanly to
2.6.8. You can the boot with "irqpoll" as a boot option and the box
should survive.

Alan

