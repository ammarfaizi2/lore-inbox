Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261219AbVG0XMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261219AbVG0XMR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 19:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbVG0XMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 19:12:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42437 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261214AbVG0XKP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 19:10:15 -0400
Date: Wed, 27 Jul 2005 16:09:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: Len Brown <len.brown@intel.com>
Cc: thecwin@gmail.com, acpi-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: ACPI buttons in 2.6.12-rc4-mm2
Message-Id: <20050727160907.7d1ed683.akpm@osdl.org>
In-Reply-To: <1122407079.13241.4.camel@toshiba.lenb.intel.com>
References: <b6d0f5fb0505220425146d481a@mail.gmail.com>
	<1122407079.13241.4.camel@toshiba.lenb.intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Len Brown <len.brown@intel.com> wrote:
>
> On Sun, 2005-05-22 at 07:25 -0400, Cameron Harris wrote:
> > I just upgraded from 2.6.11.3 and now my /proc/acpi/button directory
> > doesn't exist...
> 
> I deleted /proc/acpi/button on purpose,
> did you have a use for those files?

Can we put it back, please?

> Note that over time everything in /proc/acpi is
> going away.  In this case, there didn't seem to be
> a case for making appear in /sys.

That'll be hard.  I guess we could add the new /sys entries, make sure that
userspace tool developers have migrated and then remove the /proc entries
in a year or so.

We cannot go ripping out stuff which applications and users are currently
using without quite a lot of preparation.
