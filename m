Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264235AbTDKPK0 (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 11:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264371AbTDKPK0 (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 11:10:26 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:10626 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S264235AbTDKPKZ (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 11:10:25 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304111524.h3BFObYL001454@81-2-122-30.bradfords.org.uk>
Subject: Re: kernel hcking
To: vicky@freebsdcluster.net (Vikram Rangnekar)
Date: Fri, 11 Apr 2003 16:24:37 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030411170709.A33459@freebsdcluster.dk> from "Vikram Rangnekar" at Apr 11, 2003 05:07:09 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm a kernel newbie and just wanted to know what do most kernel hackers do
> when working on the kernel say 2.5 when you make changes do u need to
> recompile the kernel and reboot the machine to test your small modification
> or do people use something like bochs.

A lot of developers have multiple physical machines, which makes
testing various different kernels a lot easier.

> Also every time you makes changes in the kernel it must be hell to
> recompile the whole thing

If you are testing kernels on a separate machine to the one you are
compiling on, and therefore not rebooting, it's not much of a problem
- with enough RAM, most or all of the kernel source will be cached,
and you can compile a kernel in three to five minutes on a fast
machine.

John.
