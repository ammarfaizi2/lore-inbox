Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262872AbTGWJ3S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 05:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbTGWJ3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 05:29:18 -0400
Received: from mail.gmx.de ([213.165.64.20]:21155 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262872AbTGWJ3S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 05:29:18 -0400
Date: Wed, 23 Jul 2003 11:44:21 +0200
From: Dominik Brugger <dominik83@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-test1] ACPI slowdown
Message-Id: <20030723114421.34eb7149.dominik83@gmx.net>
In-Reply-To: <878yqpptez.fsf@deneb.enyo.de>
References: <878yqpptez.fsf@deneb.enyo.de>
X-Mailer: Sylpheed version 0.9.0claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jul 2003 09:57:08 +0200
Florian Weimer <fw@deneb.enyo.de> wrote:

> If I enable ACPI on my box (Athlon XP at 1.6 GHz, Epox EP-8KHa+
> mainboard), it becomes very slow (so slow that it's unusable).
> 
> Is this a known issue?  Maybe the thermal limits are misconfigured,
> and the CPU clock is throttled unnecessarily (if something like this
> is supported at all).

I use the same board with ACPI enabled, no slow down.
The only problem I experience is that USB doesnt wakeup after resume from S3, reloading all of the related modules doesnt help, the port seems to be unpowered (usb optical mouse blinks for a few miliseconds after reloading uhci_hcd, maybe there is some little power left).

-Dominik Brugger
