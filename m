Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261293AbULWVRL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbULWVRL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 16:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbULWVRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 16:17:11 -0500
Received: from mail.dif.dk ([193.138.115.101]:48314 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261293AbULWVRH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 16:17:07 -0500
Date: Thu, 23 Dec 2004 22:27:55 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Park Lee <parklee_sel@yahoo.com>
Cc: twaugh@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Something wrong when transform Documentation/DocBook/*.tmpl into
 pdf
In-Reply-To: <20041223193925.57234.qmail@web51501.mail.yahoo.com>
Message-ID: <Pine.LNX.4.61.0412232224080.3511@dragon.hygekrogen.localhost>
References: <20041223193925.57234.qmail@web51501.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Dec 2004, Park Lee wrote:

[...]
> If you just want to read the ready-made books on the
> various subsystems (see Documentation/DocBook/*.tmpl),
> just type 'make psdocs', or 'make pdfdocs', or 'make
> htmldocs', depending on your preference.
> 
>   Then, on the command line, I type the following
> commands:
> 
> cd /usr/src/linux-2.6.5-1.358/Documentation/DocBook 

Wrong, you want to be in the top of the kernel source tree, not in the 
Documentation/DocBook subdir.

cd /path/to/your/kernel/source
make pdfdocs 

you can also make docs in other formats, try running "make help" and 
you'll see this :

[...]
Documentation targets:
  Linux kernel internal documentation in different formats:
  sgmldocs (SGML), psdocs (Postscript), pdfdocs (PDF)
  htmldocs (HTML), mandocs (man pages, use installmandocs to install)
[...]


-- 
Jesper Juhl


