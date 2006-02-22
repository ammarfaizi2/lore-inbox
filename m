Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422633AbWBVA0J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422633AbWBVA0J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 19:26:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161287AbWBVA0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 19:26:08 -0500
Received: from smtp.osdl.org ([65.172.181.4]:62423 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161286AbWBVA0H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 19:26:07 -0500
Date: Tue, 21 Feb 2006 16:21:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: Kay Sievers <kay.sievers@suse.de>
Cc: penberg@cs.helsinki.fi, gregkh@suse.de, bunk@stusta.de, rml@novell.com,
       torvalds@osdl.org, linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: Re: 2.6.16-rc4: known regressions
Message-Id: <20060221162104.6b8c35b1.akpm@osdl.org>
In-Reply-To: <20060222000429.GB12480@vrfy.org>
References: <Pine.LNX.4.64.0602171438050.916@g5.osdl.org>
	<20060217231444.GM4422@stusta.de>
	<84144f020602190306o3149d51by82b8ccc6108af012@mail.gmail.com>
	<20060219145442.GA4971@stusta.de>
	<1140383653.11403.8.camel@localhost>
	<20060220010205.GB22738@suse.de>
	<1140562261.11278.6.camel@localhost>
	<20060221225718.GA12480@vrfy.org>
	<20060221153305.5d0b123f.akpm@osdl.org>
	<20060222000429.GB12480@vrfy.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kay Sievers <kay.sievers@suse.de> wrote:
>
> > We broke back-compatibility.  The changelog _failed to tell us_ that we
> > were breaking back-compatibility.  The patch wouldn't have been applied if
> > we'd been told that.  At least, not without a lot of careful thought.
> > 
> > The fact that the changelog failed to tell us this makes one suspect that
> > the breakage was inadvertent.
> > 
> > 
> > So no, upgrading HAL is not a good answer.  Please fix the kernel.
> 
> [ bunch of special-pleading ]
>

None of that matters or is relevant.

You took a kernel interface which was present in 2.6.10, 2.6.11, 2.6.12,
2.6.13, 2.6.14 and 2.6.15 and changed it in a non-compatible way, without
telling us that it was non-compatible and without even notifying people
that we'd gone and broken existing userspace.

We.  Don't.  Do. That.

Please either restore the old events so we can have a 6-12 month transition
period or revert the patch.

