Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751519AbWCIVFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519AbWCIVFj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 16:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751528AbWCIVFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 16:05:39 -0500
Received: from smtp.osdl.org ([65.172.181.4]:63892 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750901AbWCIVFj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 16:05:39 -0500
Date: Thu, 9 Mar 2006 13:03:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Jesper Juhl" <jesper.juhl@gmail.com>
Cc: tilman@imap.cc, rdunlap@xenotime.net,
       linux-usb-devel@lists.sourceforge.net, hjlipp@web.de,
       linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: [PATCH] reduce syslog clutter (take 2)
Message-Id: <20060309130327.32ef68de.akpm@osdl.org>
In-Reply-To: <9a8748490603091058l75aacacsfc5fdba3981fb074@mail.gmail.com>
References: <440F609F.8090604@imap.cc>
	<20060309030257.5c1e0f30.akpm@osdl.org>
	<20060309083412.95e145ea.rdunlap@xenotime.net>
	<44107739.9070204@imap.cc>
	<9a8748490603091058l75aacacsfc5fdba3981fb074@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jesper Juhl" <jesper.juhl@gmail.com> wrote:
>
> > Feb 21 00:12:13 gx110 kernel: gigaset: ISDN_CMD_SETL3: invalid protocol 42
>  >
>  > do not provide any useful information for that clientele. They just push
> 
>  The filename may not be useful to the user, but the instant the user decides to
>  submit a bugreport to LKML or elsewhere it becomes useful.

But OTOH, there's a difference between messages-to-developers (usually "the
code went wrong") and messages-to-users (hopefully usually "the hardware
went wrong" or "you went wrong").

So I guess the change is a good one for end-user informational messages. 
And end-users are the party who should be served, more than developers.
