Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265492AbUHWPqh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265492AbUHWPqh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 11:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265396AbUHWPqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 11:46:35 -0400
Received: from 227.80-203-45.nextgentel.com ([80.203.45.227]:50251 "EHLO
	home.gnome.no") by vger.kernel.org with ESMTP id S265108AbUHWPnZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 11:43:25 -0400
Subject: Re: Oops on suspend/resume
From: Kjartan Maraas <kmaraas@broadpark.no>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040821075023.GA603@openzaurus.ucw.cz>
References: <1092862850.7890.3.camel@home.gnome.no>
	 <20040821075023.GA603@openzaurus.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Date: Sun, 22 Aug 2004 22:02:31 +0200
Message-Id: <1093204951.4839.6.camel@home.gnome.no>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.93 (1.5.93-2) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lør, 21,.08.2004 kl. 09.50 +0200, skrev Pavel Machek:
> Hi!
> 
> > I got this when trying out suspend/resume on a HP NC8000 laptop. The
> > kernel is one of the latest from fedora development, 2.6.8-rc4-bk4 or
> > something based.
> 
> Its not oops. Try disabling preempt.
> 
I guess there's no way to do that without recompiling the kernel,
right? 

The bug is not entirely reproducable in the first place and I run into
worse problems when I actually get the machine to suspend anyway. I have
to remove the ehci-hcd and uhci-hcd modules before the machine goes to
sleep, and there's no way to get it to resume so far.

I've disabled the config to shutdown when the power button is pressed so
in theory it should resume when I hit it, but it doesn't...

Nothing in the logs after "Stopping tasks...."

Cheers
Kjartan

