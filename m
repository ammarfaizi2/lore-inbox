Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264183AbUFFWCj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264183AbUFFWCj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 18:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264188AbUFFWCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 18:02:39 -0400
Received: from fw.osdl.org ([65.172.181.6]:24210 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264183AbUFFWCg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 18:02:36 -0400
Date: Sun, 6 Jun 2004 14:55:02 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: zwane@fsmlabs.com, mingo@elte.hu, ak@suse.de, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Disable scheduler debugging
Message-Id: <20040606145502.4021b3bc.rddunlap@osdl.org>
In-Reply-To: <40C392BB.3020406@pobox.com>
References: <20040606033238.4e7d72fc.ak@suse.de>
	<20040606055336.GA15350@elte.hu>
	<40C3452B.5010500@pobox.com>
	<Pine.LNX.4.58.0406061742100.1838@montezuma.fsmlabs.com>
	<40C392BB.3020406@pobox.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 06 Jun 2004 17:55:07 -0400 Jeff Garzik wrote:

| Zwane Mwaikambo wrote:
| > On Sun, 6 Jun 2004, Jeff Garzik wrote:
| > 
| > 
| >>Unfortunately there are just, flat-out, way too many kernel messages at
| >>boot-up.  Making them KERN_DEBUG doesn't solve the fact that SMP boxes
| >>often overflow the printk buffer before you boot up to a useful userland
| >>that can record the dmesg.
| >>
| >>The IO-APIC code is a _major_ offender in this area, but the CPU code is
| >>right up there as well.
| > 
| > 
| > How about the configurable log buffer size patch? I think Andrew still has
| > that amongst his wares.
| 
| It's in mainline.  That's no excuse for the voluminous logs, though... 
| I'm a "1-2 lines per module" type of person :)

It's mainline, both CONFIG and command-line settable.

I'm a "there's always some case where more info is needed"
type of person.  But it won't happen on the next boot....
especially if the log size is increased.  :(

--
~Randy
