Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261559AbUK1SnB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261559AbUK1SnB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 13:43:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261557AbUK1SnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 13:43:00 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:12434 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261559AbUK1Sml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 13:42:41 -0500
Subject: Re: [PATCH] Documentation for IDE and CDROM ioctls.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Edward Falk <efalk@google.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41A3E17C.1000308@google.com>
References: <41A3E17C.1000308@google.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1101663529.16761.48.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 28 Nov 2004 17:38:50 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-11-24 at 01:18, Edward Falk wrote:
> The CDROM_LOCKDOOR ioctl seems to lock/unlock all doors on all drives, 
> because it uses a global variable.

Known bug/hideous ancient vendor hack that should never have been
allowed
upstream.


