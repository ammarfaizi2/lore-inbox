Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbVIIMSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbVIIMSr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 08:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbVIIMSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 08:18:47 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16359 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750769AbVIIMSp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 08:18:45 -0400
Date: Fri, 9 Sep 2005 08:18:32 -0400
From: Alan Cox <alan@redhat.com>
To: Damir Perisa <damir.perisa@solnet.ch>
Cc: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-mm2 - drivers/char/speakup/speakup doesn't compile (+warnings from other things)
Message-ID: <20050909121832.GA30359@devserv.devel.redhat.com>
References: <20050908053042.6e05882f.akpm@osdl.org> <200509090452.16097.damir.perisa@solnet.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509090452.16097.damir.perisa@solnet.ch>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2005 at 04:52:12AM +0200, Damir Perisa wrote:
> drivers/char/speakup/speakup.c:491: error: 'struct tty_ldisc' has no member named 'receive_room'
> drivers/char/speakup/speakup.c:491: error: 'struct tty_ldisc' has no member named 'receive_room'
> make[3]: *** [drivers/char/speakup/speakup.o] Error 1
> make[2]: *** [drivers/char/speakup] Error 2

Builds in my tree, may be short a diff with Linus or it may have misapplied.
I'll doublecheck when I resync.
