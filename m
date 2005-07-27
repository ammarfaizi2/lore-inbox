Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262293AbVG0Rvc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262293AbVG0Rvc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 13:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262129AbVG0RvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 13:51:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30170 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262335AbVG0RvK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 13:51:10 -0400
Date: Wed, 27 Jul 2005 10:50:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Francisco Figueiredo Jr." <fxjrlists@yahoo.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: "seeing minute plus hangs during boot" - 2.6.12 and 2.6.13
Message-Id: <20050727105005.30768fe3.akpm@osdl.org>
In-Reply-To: <42E7A153.6060307@yahoo.com.br>
References: <20050722182848.8028.qmail@web60715.mail.yahoo.com>
	<105c793f05072507426fb6d4c9@mail.gmail.com>
	<42E59E0E.5030306@yahoo.com.br>
	<20050726003322.1bfe17ee.akpm@osdl.org>
	<42E7A153.6060307@yahoo.com.br>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Francisco Figueiredo Jr." <fxjrlists@yahoo.com.br> wrote:
>
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Andrew Morton wrote:
> > "Francisco Figueiredo Jr." <fxjrlists@yahoo.com.br> wrote:
> > 
> >>Indeed udev update solved my problem with "preparing system to use udev"
> >> hang. It now works like a charm. I had 030 version too.
> >>
> >> Only the "mounting filesystem" hangs persists :(
> > 
> > 
> > Please use ALT-SYSRQ-T to generate an all-task backtrace, then send it to the
> > list.
> > 
> 
> 
> Hi Andrew.
> I was not able to get anything when I press this key sequence.
> 
> I checked my sysrq key with showkey -s as this doc
> (http://snafu.freedom.org/linux2.2/docs/sysrq.txt) says and I could
> confirm that alt+sysrq is sending 0x54.
> 
> I also noted that many said that this option has to be compiled in
> kernel, but I couldn't find this option.
> 
> Can you give me some tips?
> 

(Please leave the cc list unchanged - always do reply-to-all)

hm, maybe do alt-sysrq-7 to make sure that the loglevel is appropriately set.

Or do alt-sysrq-B to test that the whole sysrq thing is working.  If it is,
that will reboot the machine.

