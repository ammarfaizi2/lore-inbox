Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263574AbTDIQVE (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 12:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263581AbTDIQVE (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 12:21:04 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:13184 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263574AbTDIQVB (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 12:21:01 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304091635.h39GZ0ia001013@81-2-122-30.bradfords.org.uk>
Subject: Re: Linux-2.4.20 on a 4 MB Laptop
To: algernon@bonehunter.rulez.org (Gergely Nagy)
Date: Wed, 9 Apr 2003 17:35:00 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
       dusty@violin.dyndns.org
In-Reply-To: <20030409142849.GA9381@gandalph.mad.hu> from "Gergely Nagy" at Apr 09, 2003 04:28:49 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > What I want to know is if this happens just because of the low memory (4MB) or 
> > if there is another reason for this behaviour.
> 
> There must be another reason, I'm running a 80486/4Mb (Compaq Contura)
> with 2.4.20 just fine. Even networking is present. You need lots of
> swap, though.
> 
> > What do you think: What are the minimum requirements for Linux on such a 
> > laptop (no X, of course, very simple setup): 8MB, 12MB?
> 
> The very minimum? 4Mb + lots of swap. To make it closer to usable, I'd
> say 8Mb. Altough, I had this setup on my Contura: Contura connects to
> the main box via plip, another laptop (old Thinkpad) connects to Contura
> via ppp, and Contura NATs it through the main box. Meanwhile, I could
> run mutt, reading e-mail, and zile, editing some documentation. Both
> from screen. And I've been logged into the machine via ssh.
> 
> It was a bit slow, but worked. So 4Mb _is_ enough, even for running
> Debian sid.

I missed the original post in this thread, but I can confirm that
2.4.18, 2.4.19, and various 2.5 kernels have worked fine on 4 and 8 MB
RAM, 486 laptops here.

I demonstrated X, the Apache webserver with support for PHP, and Lynx
running in 4 MB of RAM last year.

Quite a lot of useful work can be done in 8 MB RAM, with no swap, and
that allows you to spin down the disk and make the batteries last
longer, (on a laptop).

Have a look at:

http://grabjohn.com/low_spec.php

for some configuration suggestions.

John.
