Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270352AbTHLQlO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 12:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270821AbTHLQlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 12:41:14 -0400
Received: from main.gmane.org ([80.91.224.249]:42406 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S270352AbTHLQlN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 12:41:13 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jens Benecke <usenet@jensbenecke.de>
Subject: Re: Linux 2.4.22-rc2
Date: Tue, 12 Aug 2003 18:41:18 +0200
Message-ID: <bhb5b7$hhf$1@sea.gmane.org>
References: <Pine.LNX.4.44.0308081751390.10734-100000@logos.cnet> <bh8vv8$3qc$1@sea.gmane.org> <20030811191833.76cbbc6d.vmlinuz386@yahoo.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: KNode/0.7.6
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerardo Exequiel Pozzi wrote:

> On Mon, 11 Aug 2003 22:57:21 +0200, Jens Benecke wrote:
>>Marcelo Tosatti wrote:
>>
>>> Here goes release candidate 2.
>>> It contains yet another bunch of important fixes, detailed below.
>>> Nice weekend for all of you!
>>
>>I'm having problems.  had them with -pre10 as well, posted here, but
>>they somehow didn't appear in the list.
>>Here's the short story: No network (3c509) because the card gets IRQ 
>>22 (or something) and doesn't like it, no USB, no firewire, no X11 
>>(yeah, should have recompiled the NVIDIA drivers, duh), and a total 
>>crash on shutdown in "rmmod" ("kernel BUG in spinlock.h:133, Aiee, 
>>killing interrupt handler") 
> 
> try with option "noapic" at boot time.

I did, this causes "APIC error on CPU0:40" or something (this wasn't
syslogged and I don't remember exactly).

Does that help?


-- 
Jens Benecke
