Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262038AbTL1UHW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 15:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbTL1UHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 15:07:22 -0500
Received: from mail.gmx.de ([213.165.64.20]:6313 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262038AbTL1UHU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 15:07:20 -0500
X-Authenticated: #11949556
From: Michael Schierl <schierlm-usenet@gmx.de>
To: arjanv@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Local APIC bug?
Date: Sun, 28 Dec 2003 21:07:28 +0100
Reply-To: schierlm@gmx.de
References: <17ss4-23P-3@gated-at.bofh.it> <17ss4-23P-5@gated-at.bofh.it> <17ss5-23P-7@gated-at.bofh.it> <17ss5-23P-9@gated-at.bofh.it> <17ss5-23P-11@gated-at.bofh.it> <17ss4-23P-1@gated-at.bofh.it> <17sLs-2sN-1@gated-at.bofh.it>
In-Reply-To: <17sLs-2sN-1@gated-at.bofh.it>
X-Mailer: Forte Agent 1.93/32.576 English (American)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Message-Id: <S262038AbTL1UHU/20031228200720Z+3779@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Dec 2003 21:00:06 +0100, in linux.kernel you wrote:

>> However, I'd appreciate if someone had any idea why the kernel crashes
>> when trying to resume. Deadlocks...?
>
>most bioses on laptops that I have seen don't actually restore the apic
>state on resume (since they don't expect the apic to be used at all)
>which results in entirely horked irq's on resume -> kernel crashes.

Thanks. However, my laptop crashes on *suspend* when APIC is on and on
*resume* when APIC is off...

And on -test3 it did not crash. 

jftr: on 2.4.x it crashed on resume as well. Someone trying to prevent
me to use stable kernels on my laptop? ;-(

Michael
-- 
"New" PGP Key! User ID: Michael Schierl <schierlm@gmx.de>
Key ID: 0x58B48CDD    Size: 2048    Created: 26.03.2002
Fingerprint:  68CE B807 E315 D14B  7461 5539 C90F 7CC8
http://home.arcor.de/mschierlm/mschierlm.asc
