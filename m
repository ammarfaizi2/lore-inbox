Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261294AbVGLJg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbVGLJg2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 05:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261290AbVGLJeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 05:34:11 -0400
Received: from gwbw.xs4all.nl ([213.84.100.200]:14557 "EHLO
	laptop.blackstar.nl") by vger.kernel.org with ESMTP id S261297AbVGLJdZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 05:33:25 -0400
Subject: Re: 2.6.13-rc2 (git followed) unable to boot with initrd
From: Bas Vermeulen <bvermeul@blackstar.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050712012508.3c5fbb19.akpm@osdl.org>
References: <1121092944.6432.4.camel@laptop.blackstar.nl>
	 <20050712012508.3c5fbb19.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 12 Jul 2005 11:33:18 +0200
Message-Id: <1121160799.5109.1.camel@laptop.blackstar.nl>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-14.WB1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-12 at 01:25 -0700, Andrew Morton wrote:
> Bas Vermeulen <bvermeul@blackstar.nl> wrote:
> >
> > I am currently unable to boot 2.6.13-rc2. I've got a working 2.6.13-rc1
> >  whose .config I use to compile 2.6.13-rc2. I'm attaching the failed boot
> >  log to this message. I'm booting with the same options as 2.6.13-rc1.
> > 
> >  If anyone knows how to get it working again, I'd be grateful.
> > ...
> > VFS: Cannot open root device "LABEL=/" or unknown-block(0,0)
> > ...
> 
> This normally has a simple cause: it didn't find any disks, or a filesystem
> driver is missing.  Check your .config carefully and if that seems OK,
> generate the -rc1 and -rc2 dmesg and diff them, send us the result.

Just rebuilt -rc2 from tarball and patch, and that is working fine. So
it's probably my cogito/git screwing up. I'll download that again, and
try some more.

-- 
Bas Vermeulen <bvermeul@blackstar.nl>

