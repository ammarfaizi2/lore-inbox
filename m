Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263424AbTDIORJ (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 10:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263425AbTDIORJ (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 10:17:09 -0400
Received: from gandalph.mad.hu ([193.225.158.7]:49164 "EHLO gandalph.mad.hu")
	by vger.kernel.org with ESMTP id S263424AbTDIORI (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 10:17:08 -0400
Date: Wed, 9 Apr 2003 16:28:49 +0200
From: Gergely Nagy <algernon@bonehunter.rulez.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: dusty@violin.dyndns.org
Subject: Re: Linux-2.4.20 on a 4 MB Laptop
Message-ID: <20030409142849.GA9381@gandalph.mad.hu>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	dusty@violin.dyndns.org
References: <200304091601.55821.dusty@violin.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <200304091601.55821.dusty@violin.dyndns.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What I want to know is if this happens just because of the low memory (4MB) or 
> if there is another reason for this behaviour.

There must be another reason, I'm running a 80486/4Mb (Compaq Contura)
with 2.4.20 just fine. Even networking is present. You need lots of
swap, though.

> What do you think: What are the minimum requirements for Linux on such a 
> laptop (no X, of course, very simple setup): 8MB, 12MB?

The very minimum? 4Mb + lots of swap. To make it closer to usable, I'd
say 8Mb. Altough, I had this setup on my Contura: Contura connects to
the main box via plip, another laptop (old Thinkpad) connects to Contura
via ppp, and Contura NATs it through the main box. Meanwhile, I could
run mutt, reading e-mail, and zile, editing some documentation. Both
from screen. And I've been logged into the machine via ssh.

It was a bit slow, but worked. So 4Mb _is_ enough, even for running
Debian sid.
