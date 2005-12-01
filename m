Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751402AbVLAAkI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbVLAAkI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 19:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbVLAAkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 19:40:07 -0500
Received: from smtp.osdl.org ([65.172.181.4]:13974 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751402AbVLAAkG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 19:40:06 -0500
Date: Wed, 30 Nov 2005 16:41:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, zippel@linux-m68k.org,
       george@mvista.com, johnstul@us.ibm.com
Subject: Re: [patch 00/43] ktimer reworked
Message-Id: <20051130164105.40e103d4.akpm@osdl.org>
In-Reply-To: <1133395019.32542.443.camel@tglx.tec.linutronix.de>
References: <1133395019.32542.443.camel@tglx.tec.linutronix.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> wrote:
>
> this patch series is a refactored version of the ktimer-subsystem patch.

 25 files changed, 3364 insertions(+), 1827 deletions(-)

allnoconfig, before:

   text    data     bss     dec     hex filename
 764888  157221   53748  975857   ee3f1 vmlinux

after:

   text    data     bss     dec     hex filename
 766712  157741   53748  978201   eed19 vmlinux


Remind me what we gained for this?
