Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262131AbUJZE0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262131AbUJZE0g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 00:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbUJZBjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 21:39:20 -0400
Received: from zeus.kernel.org ([204.152.189.113]:471 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262090AbUJZBXp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 21:23:45 -0400
To: Christophe Saout <christophe@saout.de>
Cc: linux-kernel@vger.kernel.org, Alasdair G Kergon <agk@redhat.com>
Subject: Re: 2.6.9-mm1: LVM stopped working
References: <87oeitdogw.fsf@barad-dur.crans.org>
	<1098731002.14877.3.camel@leto.cs.pocnet.net>
From: Mathieu Segaud <matt@minas-morgul.org>
Date: Tue, 26 Oct 2004 00:31:01 +0200
In-Reply-To: <1098731002.14877.3.camel@leto.cs.pocnet.net> (Christophe Saout's
	message of "Mon, 25 Oct 2004 21:03:22 +0200")
Message-ID: <87acuawhui.fsf@barad-dur.crans.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Saout <christophe@saout.de> disait dernièrement que :

> Are you encrypting your PV or your LVs?

non they are not encrypted, I thought about the new iv but my aes-encrypted
/ still boot :)
I wonder if it comes from some ide changes, as the messages from vgscan and
vgchange indicate that LABEL areas are detected, but cannot be read....

quite weird as anything else works quite well...

>
> There's some new dm-crypt code in -mm1 along with some API changes, but
> backward compatibility is provided and should work.

Best regards,

Mathieu

-- 
printk("----------- [cut here ] --------- [please bite here ] ---------\n");
        linux-2.6.6/arch/x86_64/kernel/traps.

