Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261562AbTFAHQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 03:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbTFAHQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 03:16:26 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:50648 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S261562AbTFAHQZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 03:16:25 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Paul P Komkoff Jr <i@stingr.net>, linux-kernel@vger.kernel.org
Subject: Re: ACPI interrupt storm (was Re: Linux 2.4.21rc6-ac1)
Date: Sun, 1 Jun 2003 17:31:04 +1000
User-Agent: KMail/1.5.1
References: <200305311153.h4VBrNi21640@devserv.devel.redhat.com> <3ED9158E.2080904@xss.co.at> <20030601072329.GB6067@stingr.net>
In-Reply-To: <20030601072329.GB6067@stingr.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306011731.04743.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Jun 2003 17:23, Paul P Komkoff Jr wrote:
> Replying to Andreas Haumer:
> > 2.) ACPI itself doesn't work right anymore and makes the system
> >     unusable... :-(
> >     It did work with the last AC kernel I tried (2.4.21-rc2-ac2)
> >
> >     Symptoms are:
> >     No ethernet, NIC (Intel eepro100) doesn't get interrupts,
> >     ACPI interrupt "storm" (millions of IRQ in a few minutes)
> >
> >     Booting with "acpi=off" makes the system work again, but without
> >     ACPI, of course.
> >
> >     Here are a few more infos from the running system:
> >
> >     Asus P4B motherboard, P4 1.6GHz processor, 1.2GB RAM
>
> I am here experiencing almost same behavior, but I didnt collected enough
> data to isolate the problem
> few points:
> 1. It is new acpi code, backported by alan in latest -ac. Previous (2.4)
> acpi "works" (err, it's outdated and more but at least no interrupt storm).
> I didnt tried running 2.5 on the target machine yet.
>
> 2. all other devices working fine. The only visible things are slow mouse
> responsiveness and >60k interrupts per second at vmstat output
>
> The box is p4-based fujitsu scenic. More information is available on
> request. And I will try 2.5 on it soon.

I get the same problem here with acpi-20030522 applied to rc6
P4 2.53 on an i845 mobo (P4PE).

Con
