Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269150AbUICPCg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269150AbUICPCg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 11:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269238AbUICPCf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 11:02:35 -0400
Received: from the-village.bc.nu ([81.2.110.252]:10644 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269150AbUICPCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 11:02:32 -0400
Subject: Re: Nasty IDE crasher in 2.6.9rc1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: Alan Cox <alan@redhat.com>, torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, axboe@suse.dk
In-Reply-To: <20040903145054.GQ1631@suse.de>
References: <20040831142335.GA15841@devserv.devel.redhat.com>
	 <20040903145054.GQ1631@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094219998.7975.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 03 Sep 2004 14:59:59 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-09-03 at 15:50, Jens Axboe wrote:
> (suse.dk is not related to suse.de and it helpfully eats all messages
> sent to unknown users. not so great :(

Ah sorry.

> > Another problem with barrier is that it can take several minutes worst case
> > for the command to complete on a large modern drive (timings c/o friendly
> > ide drive engineer). That causes two problems I've pointed out to Jens that
> > we need to fix before barriers are IMHO production grade
> 
> Can you pass me his results?

I can ask. Its NDA data (not Maxtor). Or Eric might have public info ?
The later mail I reported my tests trying to make it as slow as possible
and I couldn't get worse than 7 seconds for the command.

> > 2.	The timeouts on the command issue appear to be too small, and
> > 	we will time out and reset the drive in loaded situations. 
> 
> You don't seem to address that in your patch?

I'm not sure what the right answer is.


