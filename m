Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265686AbTBTWeh>; Thu, 20 Feb 2003 17:34:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265687AbTBTWeh>; Thu, 20 Feb 2003 17:34:37 -0500
Received: from havoc.daloft.com ([64.213.145.173]:23453 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S265686AbTBTWed>;
	Thu, 20 Feb 2003 17:34:33 -0500
Date: Thu, 20 Feb 2003 17:44:33 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, torvalds@transmeta.com,
       ak@suse.de, davem@redhat.com
Subject: Re: ioctl32 consolidation
Message-ID: <20030220224433.GV9800@gtf.org>
References: <20030220223119.GA18545@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030220223119.GA18545@elf.ucw.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2003 at 11:31:19PM +0100, Pavel Machek wrote:
> Currently, 32-bit emulation in kernel has *5* copies, and its >1000
> lines each.

Yes :/  Consolidating all these copies into a single layer has been a
"project to be" for quite some time.

I do not know if it is too late in 2.5.x to begin this work, however.
We _are_ in a feature freeze...  I suppose it is up to the consensus of
arch maintainers, because it [obviously] does not affect ia32.

	Jeff



