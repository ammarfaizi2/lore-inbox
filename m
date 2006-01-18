Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964852AbWARCmR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964852AbWARCmR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 21:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbWARCmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 21:42:16 -0500
Received: from smtp.osdl.org ([65.172.181.4]:30398 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964852AbWARCmP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 21:42:15 -0500
Date: Tue, 17 Jan 2006 18:33:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: torvalds@osdl.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Reuben Farrelly <reuben-lkml@reub.net>
Subject: Re: [git patches] 2.6.x libata updates
Message-Id: <20060117183318.1031c0d2.akpm@osdl.org>
In-Reply-To: <20060118021530.GA23108@havoc.gtf.org>
References: <20060118021530.GA23108@havoc.gtf.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
>  Please pull from 'upstream-linus' branch of
>  master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

I worry that whatever it is which has busted Reuben's machine will leak
into mainline.  This patch probably isn't it.

I guess if we can feed libata and acpi into mainline in little bits and
pieces like this, that'll help us work out the cause.

Reuben has spent ages bisecting lots of patches, but the bug is quite
intermittent, which makes the process quite maddeningly error-prone and
slow.

Then again, perhaps merging it up is the best way of fixing it: someone out
there will hit the thing more repeatably and will have a better shot at
finding the cause.


