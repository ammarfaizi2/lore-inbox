Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263662AbTHWVy3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 17:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263733AbTHWVy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 17:54:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:62982 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263662AbTHWVx1 (ORCPT
	<rfc822;linux-kernel@vger.redhat.com>);
	Sat, 23 Aug 2003 17:53:27 -0400
Date: Sat, 23 Aug 2003 14:55:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Tomasz Torcz <zdzichu@irc.pl>
Cc: linux-kernel@vger.redhat.com
Subject: Re: 2.6.0-test4 - lost ACPI
Message-Id: <20030823145545.2b7d6ec9.akpm@osdl.org>
In-Reply-To: <20030823105243.GA1245@irc.pl>
References: <20030823105243.GA1245@irc.pl>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz Torcz <zdzichu@irc.pl> wrote:
>
> I am using ACPI for few years now. As far as I can see, on my
>  machine it is only usfeul for binding events to Power button (like
>  running fbdump) and for powering off. I'm also experimenting
>  with swsusp, which I run by /proc/acpi/sleep.
> 
>  2.6.0-test4 has a surprise for me:

me too.

>  ACPI disabled because your bios is from 00 and too old
>  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

One of my trusty-but-old testboxes does exactly the same thing.  It's just
the ACPI guys running away from broken BIOSes I think ;)

Add "acpi=force" to your kernel boot command line and everything should work
as before.

