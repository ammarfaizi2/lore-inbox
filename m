Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267397AbUJGRD3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267397AbUJGRD3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 13:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267431AbUJGRBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 13:01:45 -0400
Received: from witte.sonytel.be ([80.88.33.193]:35547 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S267433AbUJGQ2N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 12:28:13 -0400
Date: Thu, 7 Oct 2004 18:28:04 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Hollis Blanchard <hollisb@us.ibm.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Greg Kroah-Hartman <greg@kroah.com>, katzj@redhat.com
Subject: Re: [patch] add class/tty/console/real_dev symlink
In-Reply-To: <200410061830.52563.hollisb@us.ibm.com>
Message-ID: <Pine.GSO.4.61.0410071827370.9319@waterleaf.sonytel.be>
References: <200410061830.52563.hollisb@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Oct 2004, Hollis Blanchard wrote:
> This patch adds a symlink from /sys/class/tty/console/real_dev to 
> e.g. /sys/class/tty/ttyS0 . This is needed because there is no way for 
> userspace to determine what device the kernel is using as its console, and in 
> the case of an installer that is important information. Otherwise, the 
> installer cannot know which serial port you're booting on, for example, and 
> so wouldn't know where to display itself.

The installer can just open /dev/console?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
