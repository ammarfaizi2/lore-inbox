Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268333AbUIKW2L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268333AbUIKW2L (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 18:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268347AbUIKW2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 18:28:11 -0400
Received: from smtp801.mail.sc5.yahoo.com ([66.163.168.180]:47793 "HELO
	smtp801.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268333AbUIKW2I convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 18:28:08 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc1-mm4: allow-i8042-register-location-override-2.patch
Date: Sat, 11 Sep 2004 17:27:55 -0500
User-Agent: KMail/1.6.2
Cc: Sean Neakums <sneakums@zork.net>, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Dmitry Torokhov <dtor@mail.ru>, Andrew Morton <akpm@osdl.org>
References: <6uy8jg4hp9.fsf@zork.zork.net>
In-Reply-To: <6uy8jg4hp9.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Message-Id: <200409111727.56934.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 11 September 2004 04:30 pm, Sean Neakums wrote:
> > Input: Add ACPI-based i8042 keyboard and aux controller enumeration;
> > can be disabled by passing i8042.noacpi as a boot parameter.
> 
> On a whim I decided to turn on ACPI, only to discover that my keyboard
> no longer worked.  Passing i8042.noacpi=1 makes it work again.
> Attached please find boot messages with and without the boot
> parameter.  Inlined below is a diff of the two.

Bjorn has a patch that would use defaults if ports/IRQ are not specified
in the DSDT table, which should help in your case I think.

-- 
Dmitry
