Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbTJHUcB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 16:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261774AbTJHUcA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 16:32:00 -0400
Received: from natsmtp01.rzone.de ([81.169.145.166]:5352 "EHLO
	natsmtp01.rzone.de") by vger.kernel.org with ESMTP id S261507AbTJHUb6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 16:31:58 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH] cleanup of compat_ioctl functions
Date: Wed, 8 Oct 2003 22:26:15 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <200310081809.42859.arnd@arndb.de> <20031008192929.GC1035@elf.ucw.cz>
In-Reply-To: <20031008192929.GC1035@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310082226.15104.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 October 2003 21:29, Pavel Machek wrote:
> Also __u32 should not be used here, it looks too ugly and u32 is
> okay. Same for __u16 and __u64. Its simple search&replace, and as you
> are doing lots of changes, anyway....

Well, in the light of 'strictly bug fixes only', it was probably too
much search&replace already. I guess I'll have to prepare a new patch 
that just fixes the bugs in the current s390 compat_ioctl code and not 
use fs/compat_ioctl.c in 2.6.0.

	Arnd <><

