Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262853AbUB0NVe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 08:21:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262858AbUB0NVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 08:21:33 -0500
Received: from chaos.analogic.com ([204.178.40.224]:64897 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262853AbUB0NV3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 08:21:29 -0500
Date: Fri, 27 Feb 2004 08:23:07 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Tim Bird <tim.bird@am.sony.com>
cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Why no interrupt priorities?
In-Reply-To: <403E5EF7.7080309@am.sony.com>
Message-ID: <Pine.LNX.4.53.0402270820060.6853@chaos>
References: <403E4363.2070908@am.sony.com> <Pine.LNX.4.53.0402261423170.4239@chaos>
 <403E5EF7.7080309@am.sony.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Feb 2004, Tim Bird wrote:

> Richard B. Johnson wrote:
> > On Thu, 26 Feb 2004, Tim Bird wrote:
> >
> >>What's the rationale for not supporting interrupt priorities
> >>in the kernel?
> >
> > Interrupt priorities are supported and have been supported
> > since the first cascaded interrupt controllers and, now
> > with the APIC.
>
> Please forgive my ignorance.  I'm not sure what's going
> on with 2.6 and work queues, but do the hardware priorities
> allow you to control scheduling of interrupt bottom halves?
>

Only to the extent that the bottom halves will naturally
occur after the hardware interrupt. There is no explicit
"hold execution until something else is done" in the queue.

It is a queue, i.e., one task after another.

> =============================
> Tim Bird
> Architecture Group Co-Chair
> CE Linux Forum
> Senior Staff Engineer
> Sony Electronics
> E-mail: Tim.Bird@am.sony.com
> =============================
>

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


