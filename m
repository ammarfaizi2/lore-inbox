Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265344AbTLHPDg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 10:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265365AbTLHPDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 10:03:36 -0500
Received: from mta02.alltel.net ([166.102.165.144]:19933 "EHLO
	mta02-srv.alltel.net") by vger.kernel.org with ESMTP
	id S265344AbTLHPDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 10:03:34 -0500
Subject: Re: 2.6 Test 11 Freeze on USB Disconnect
From: "Jonathan A. Zdziarski" <jonathan@nuclearelephant.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20031208074509.GB24585@kroah.com>
References: <1070825737.2978.7.camel@tantor.nuclearelephant.com>
	 <20031208004742.GB23644@kroah.com>
	 <1070851506.2942.0.camel@tantor.nuclearelephant.com>
	 <20031208074509.GB24585@kroah.com>
Content-Type: text/plain
Message-Id: <1070895991.2928.6.camel@tantor.nuclearelephant.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 08 Dec 2003 10:06:31 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When the kernel dies, it usually emits a oops.  If you are running X at
> the time, you can't see it.
> 
> Can you try removing the device when at a console screen?

Ah...Linux Bluescreen.  Cool.

I wrote down as much as I could before running out of paper.  Info is
below.  This info isn't available via dmesg or anything is it?

Oops: 0002[#1]
CPU 0
EIP 0060:[<228635f7>] Tained: GF
EFLAGS: 00010002
EIP is at uhci_remove_pending_qhs + 0x7d/0xcc [uhci_hcd]
eax: 2158b938
ebx: 21586938
ecx: 6b6b6b9f
edx: 18fa4000
esi: 6b6b6b6b
ed: 00000083
ebp: 0c36753c
esp: 18fa5f2c

Process klogd:

[Some numbers I didn't have room for]

Code: 89 46 34 89 48 04 89 0b 89 59 04 57 9d 8b 42 08 ff 4a 14 83

Kernel Panic: Fatal Exception in Interrupt

in Interrupt Handler: not_syncing


