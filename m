Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265322AbUFBCk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265322AbUFBCk3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 22:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265332AbUFBCk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 22:40:29 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:62392 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S265322AbUFBCk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 22:40:28 -0400
To: Hirokazu Takata <takata@linux-m32r.org>
Cc: linux-kernel@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH] m32r - Upgrade to v2.6.6 kernel
References: <20040528.131611.28785624.takata.hirokazu@renesas.com>
	<20040528072336.GD7499@pazke> <swfy8ncirnv.wl@renesas.com>
From: Miles Bader <miles@lsi.nec.co.jp>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
Date: Wed, 02 Jun 2004 11:40:18 +0900
In-Reply-To: <swfy8ncirnv.wl@renesas.com> (Hirokazu Takata's message of
 "Fri, 28 May 2004 22:53:56 +0900")
Message-ID: <buozn7mfzsd.fsf@mctpc71.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hirokazu Takata <takata@linux-m32r.org> writes:
>> We're currently working with Jeff Garzik to merge a SMC91x driver which
>> which can drive SMC91C111 chips from Nicolas Pitre.  It would be good
>> if m32r could use this driver as well.
>
> It is a good news. 
> We would like to try your SMC91x driver.

Me too!

uClinux has an SMC9111 driver which I now use, but it would be good if
the base kernel worked (I _think_ that driver's the only reason it
doesn't on this platform).

[Hmmm, uClinux also contains patches to the SMC9194 driver; I wonder if
they should be merged?  Some of the changes seem kind of ugly though
(lots of platform-specific #ifdefs).]

-Miles
-- 
A zen-buddhist walked into a pizza shop and
said, "Make me one with everything."
