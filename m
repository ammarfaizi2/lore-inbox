Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbTJHVgY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 17:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261799AbTJHVgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 17:36:24 -0400
Received: from gprs148-130.eurotel.cz ([160.218.148.130]:46721 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261798AbTJHVgU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 17:36:20 -0400
Date: Wed, 8 Oct 2003 23:35:44 +0200
From: Pavel Machek <pavel@suse.cz>
To: "David S. Miller" <davem@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cleanup of compat_ioctl functions
Message-ID: <20031008213544.GB1238@elf.ucw.cz>
References: <200310081809.42859.arnd@arndb.de> <20031008192929.GC1035@elf.ucw.cz> <200310082226.15104.arnd@arndb.de> <20031008140207.666a62c9.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031008140207.666a62c9.davem@redhat.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Well, in the light of 'strictly bug fixes only', it was probably too
> > much search&replace already. I guess I'll have to prepare a new patch 
> > that just fixes the bugs in the current s390 compat_ioctl code and not 
> > use fs/compat_ioctl.c in 2.6.0.
> 
> That doesn't make any sense, the fact that fs/compat_ioctl.c isn't
> using the proper compat user pointer accessor macros is a bug,
> so just fix that.
> 
> It defeats the whole purpose of this compat layer if people still
> need to duplicate the code in some cases.

Agreed, your changes are trivial and reviewed extremely easily. That
is not going to break anything. Okay, I guess no need to change __u16
into anything...
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
