Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268662AbUILLH4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268662AbUILLH4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 07:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268663AbUILLH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 07:07:56 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:63953 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S268662AbUILLHz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 07:07:55 -0400
Date: Sun, 12 Sep 2004 13:06:15 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: sneakums@zork.net
Cc: jgarzik@pobox.com, akpm@osdl.org, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm4: r8169: irq 16: nobody cared!/TX Timeout
Message-ID: <20040912110614.GA20942@electric-eye.fr.zoreil.com>
References: <6upt4s4cro.fsf@zork.zork.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6upt4s4cro.fsf@zork.zork.net>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Neakums <sneakums@zork.net> :
[r8169 irq delivery/Tx timeout issue]
> I downed and upped the interface and it started working again.

There is a gross error in the 2.6.9-rc1-mm4 version of the r8169 driver
which could be related to your bug.

A few patches have been posted on netdev amongst which the first should
make things better (see [PATCH 2.6.9-rc1-mm4 x/4] on netdev the 10 of
september 2004)

Can you apply the patch below on top of 2.6.9-rc1-mm4 and report
if it makes things better:
http://www.fr.zoreil.com/linux/kernel/2.6.x/2.6.9-rc1-mm4/r8169/r8169-130.patch

--
Ueimor
