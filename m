Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266002AbUBCNnq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 08:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266010AbUBCNnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 08:43:46 -0500
Received: from chaos.analogic.com ([204.178.40.224]:33667 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S266002AbUBCNno convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 08:43:44 -0500
Date: Tue, 3 Feb 2004 08:45:24 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Martin =?iso-8859-2?Q?Povoln=FD?= <xpovolny@aurora.fi.muni.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0, cdrom still showing directories after being erased
In-Reply-To: <20040203131837.GF3967@aurora.fi.muni.cz>
Message-ID: <Pine.LNX.4.53.0402030839380.31203@chaos>
References: <20040203131837.GF3967@aurora.fi.muni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Feb 2004, Martin [iso-8859-2] Povolný wrote:

> I have debian's 2.6.0-686-smp only with PNP BIOS disabled (fails to
> boot with enabled, as described by other people).
>
> I did
>
> $ mount /cdrom/
> $ ls /cdrom/
>
> got listing of files and directories on the cdrom
> then
>
> $ cdrecord dev=/dev/hdc -blank=fast -v
> ...
> Blanking time:   21.570s
> $ mount /cdrom
> $ ls /cdrom

Can you really initialize the CDROM while it's mounted? Although
the kernel doesn't care, cdrecord should. Suggest that you
contact the cdrecord author.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


