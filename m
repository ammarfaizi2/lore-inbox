Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932541AbWIVOfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932541AbWIVOfr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 10:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932543AbWIVOfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 10:35:47 -0400
Received: from smtp.reflexsecurity.com ([72.54.64.74]:48077 "EHLO
	crown.reflexsecurity.com") by vger.kernel.org with ESMTP
	id S932542AbWIVOfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 10:35:46 -0400
Date: Fri, 22 Sep 2006 10:35:39 -0400
From: Jason Lunz <lunz@falooley.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J\. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, Dave Jones <davej@redhat.com>
Subject: Re: [PATCH -mm 5/6] mm: Print first block offset for swap areas
Message-ID: <20060922143539.GC28949@opus.vpn-dev.reflex>
References: <20060921235340.DBD89822B@knob.reflex> <20060921235817.GA27170@knob.reflex> <200609221257.12303.rjw@sisk.pl> <20060922141346.GA28949@opus.vpn-dev.reflex> <20060922141817.GN3478@elf.ucw.cz>
In-Reply-To: <20060922141817.GN3478@elf.ucw.cz>
User-Agent: Mutt/1.5.13 (2006-08-11)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, most people "solve" this by having their boot partition on ext2,
> no?

my grub appears to handle ext2/3, reiser3, xfs, jfs, fat, and minix.

> Anyway, yes, you can do libext2 magic... in uswsusp..

a hybrid approach might work, with grub-like support for common filesystems and
the ability to specify the resume_offset on the kernel command line as a fallback.

Jason
