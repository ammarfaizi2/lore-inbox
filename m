Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292130AbSCIBJy>; Fri, 8 Mar 2002 20:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292238AbSCIBJo>; Fri, 8 Mar 2002 20:09:44 -0500
Received: from jhuml3.jhu.edu ([128.220.2.66]:59632 "EHLO jhuml3.jhu.edu")
	by vger.kernel.org with ESMTP id <S292130AbSCIBJc>;
	Fri, 8 Mar 2002 20:09:32 -0500
Date: Fri, 08 Mar 2002 20:10:32 -0500
From: Thomas Hood <jdthood@mail.com>
Subject: Re: PnP BIOS driver status
In-Reply-To: <3C895E90.696E92A2@didntduck.org>
To: Brian Gerst <bgerst@didntduck.org>
Cc: linux-kernel@vger.kernel.org
Message-id: <1015636233.988.9.camel@thanatos>
MIME-version: 1.0
X-Mailer: Evolution/1.0.2
Content-type: text/plain
Content-transfer-encoding: 7bit
In-Reply-To: <1015628440.14518.212.camel@thanatos>
 <3C895E90.696E92A2@didntduck.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-03-08 at 20:00, Brian Gerst wrote:
> The current driver is not SMP-safe.

That's true.

> It is modifying the GDT descriptors
> outside of the pnp_bios_lock.  Also, you can remove the __cli(), as
> spin_lock_irq() already turns off interrupts.

I'd welcome a patch like the return of a kidnapped pet.

--
Thomas

