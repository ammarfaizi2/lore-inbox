Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbTGCMS7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 08:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbTGCMS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 08:18:59 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:41220 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S261168AbTGCMS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 08:18:58 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Chris Mason <mason@suse.com>, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: Status of the IO scheduler fixes for 2.4
Date: Thu, 3 Jul 2003 14:31:27 +0200
User-Agent: KMail/1.5.2
Cc: lkml <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrea Arcangeli <andrea@suse.de>, Nick Piggin <piggin@cyberone.com.au>
References: <Pine.LNX.4.55L.0307021923260.12077@freak.distro.conectiva> <Pine.LNX.4.55L.0307021927370.12077@freak.distro.conectiva> <1057197726.20903.1011.camel@tiny.suse.com>
In-Reply-To: <1057197726.20903.1011.camel@tiny.suse.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307031431.27153.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 July 2003 04:02, Chris Mason wrote:

Hi Chris,

> So, the patch attached includes the q->full code but has it off by
> default.  I've got code locally for an elvtune interface that can toggle
> q->full check on a per device basis, as well as tune the max io per
> queue.  I've got two choices on how to submit it, I can either add a new
> ioctl or abuse the max_bomb_segments field in the existing ioctl.
> If we can agree on the userland tuning side, I can have some kind of
> elvtune patch tomorrow.
what about /proc ?

ciao, Marc

