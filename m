Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267235AbUJNVWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267235AbUJNVWs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 17:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267378AbUJNVQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 17:16:40 -0400
Received: from mail.dif.dk ([193.138.115.101]:53394 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S267235AbUJNVPK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 17:15:10 -0400
Date: Thu, 14 Oct 2004 23:22:59 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: kilian@bobodyne.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Driver access ito PCI card memory space question.
In-Reply-To: <200410142047.i9EKlkg12327@raceme.attbi.com>
Message-ID: <Pine.LNX.4.61.0410142317480.2986@dragon.hygekrogen.localhost>
References: <200410142047.i9EKlkg12327@raceme.attbi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Oct 2004 kilian@bobodyne.com wrote:

> 
>   Hey! what RPM do I install so I can get man pages for kernel
>   functions? A man page for readl() sure would have been useful.
> 
I don't know about any RPM for that (using a non-rpm based distribution), 
but what I do personally is use "make mandocs" and "make installmandocs".

If you run "make help" in the kernel source tree you'll see this bit:

[...]
Documentation targets:
  Linux kernel internal documentation in different formats:
  sgmldocs (SGML), psdocs (Postscript), pdfdocs (PDF)
  htmldocs (HTML), mandocs (man pages, use installmandocs to install)
[...]

As you see you can get docs in various forms.

Hope that helps.

--
Jesper Juhl


