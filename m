Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751660AbWCIVTW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751660AbWCIVTW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 16:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751735AbWCIVTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 16:19:22 -0500
Received: from mx1.redhat.com ([66.187.233.31]:12696 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751608AbWCIVTV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 16:19:21 -0500
Date: Thu, 9 Mar 2006 13:18:47 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: jesper.juhl@gmail.com, tilman@imap.cc, rdunlap@xenotime.net,
       linux-usb-devel@lists.sourceforge.net, hjlipp@web.de,
       linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: [PATCH] reduce syslog clutter (take 2)
Message-Id: <20060309131847.44e1ab79.zaitcev@redhat.com>
In-Reply-To: <20060309130327.32ef68de.akpm@osdl.org>
References: <440F609F.8090604@imap.cc>
	<20060309030257.5c1e0f30.akpm@osdl.org>
	<20060309083412.95e145ea.rdunlap@xenotime.net>
	<44107739.9070204@imap.cc>
	<9a8748490603091058l75aacacsfc5fdba3981fb074@mail.gmail.com>
	<20060309130327.32ef68de.akpm@osdl.org>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.13; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Mar 2006 13:03:27 -0800, Andrew Morton <akpm@osdl.org> wrote:
> "Jesper Juhl" <jesper.juhl@gmail.com> wrote:
> >
> > > Feb 21 00:12:13 gx110 kernel: gigaset: ISDN_CMD_SETL3: invalid protocol 42
> >  >
> >  > do not provide any useful information for that clientele. They just push
> > 
> >  The filename may not be useful to the user, but the instant the user decides to
> >  submit a bugreport to LKML or elsewhere it becomes useful.
> 
> But OTOH, there's a difference between messages-to-developers (usually "the
> code went wrong") and messages-to-users (hopefully usually "the hardware
> went wrong" or "you went wrong").

Symbol names are generally unique. As a USB stack developer, I never saw
the file name being useful for anything in the error message, let alone
the full path! Always hated them, but never bothered to break spears
over the issue. We have better things to do. I just quietly remove
debugging printouts from the code I touch.

-- Pete
