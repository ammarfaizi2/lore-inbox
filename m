Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbTHYSOh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 14:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262070AbTHYSOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 14:14:36 -0400
Received: from chaos.analogic.com ([204.178.40.224]:31619 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262092AbTHYSOe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 14:14:34 -0400
Date: Mon, 25 Aug 2003 14:14:57 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "Trever L. Adams" <tadams-lists@myrealbox.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0test4 ACPI with nForce2 success
In-Reply-To: <1061834424.2599.2.camel@aurora.localdomain>
Message-ID: <Pine.LNX.4.53.0308251412140.20628@chaos>
References: <1061834424.2599.2.camel@aurora.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Aug 2003, Trever L. Adams wrote:

> I have been one of these people who have been having to boot with
> pci=noacpi to get up with much of my hardware initialized.  My system is
> now working without it.  It isn't getting shutoff on irq storms or
> anything.
>
> My only possible problem is this:
>
>  13:59:40  up 8 min,  3 users,  load average: 0.86, 0.81, 0.36
>            CPU0
>   0:     516847          XT-PIC  timer
>

8 mins ~  8 * 60 = 480 seconds
516847 / 480 = 1076...

Looks like your HZ value is 1024. If so, everything is fine.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


