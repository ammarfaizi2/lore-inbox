Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261814AbVA3WOD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261814AbVA3WOD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 17:14:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261810AbVA3WOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 17:14:03 -0500
Received: from out005pub.verizon.net ([206.46.170.143]:3316 "EHLO
	out005.verizon.net") by vger.kernel.org with ESMTP id S261808AbVA3WLC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 17:11:02 -0500
Message-ID: <41FD5EFB.D6E39F5E@gte.net>
Date: Sun, 30 Jan 2005 14:26:03 -0800
From: Bukie Mabayoje <bukiemab@gte.net>
X-Mailer: Mozilla 4.78 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: IPMI smbus and Intel 6300ESB Watchdog drivers
References: <20050130184401.GC3373@hardeman.nu>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Authentication-Info: Submitted using SMTP AUTH at out005.verizon.net from [66.199.68.159] at Sun, 30 Jan 2005 16:11:01 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



David Härdeman wrote:

> Hi,
>
> (third question to LKML today =)
>
> I've recently bought an Intel SE7210TP1-E mainboard (specs here:
> http://www.intel.com/design/servers/boards/SE7210TP1-E/index.htm) and I
> now have most things working.
>
> There are however, two questionmarks left.
>
> 1) On the mainboard is a 6300ESB Watchdog Timer (pci id 8086:25ab), but
> there seems to be no driver available for it.

6300ESB is not a Watchdog Timer. It is an I/O Controller hub that includes a watch dog timer.

> Does anyone know if there
> is any such driver in progress or if I've misunderstood the situation?

If you tell me why you are interested in the WDT, then maybe I will be able answer your question.

>
>
> 2) IPMI, Documentation/IPMI.txt mentions a ipmi_smb driver, but I could
> find no such driver in the 2.6.10 tree. Am I missing something?

Do you get the ISM package that shipped with the board? The ISM software stack in not part of the kernel. The IPMI stuff is part of Server Management.

>
>
> Thanks in advance for any enlightenment.
>
> Regards,
> David Härdeman
>
> Not subscribed...please CC me on any replies...
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
