Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264867AbTIJF6o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 01:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264879AbTIJF6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 01:58:43 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:58598 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S264867AbTIJF6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 01:58:42 -0400
From: Fedor Karpelevitch <fedor@karpelevitch.net>
To: Russell King <rmk@arm.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       David Jones <davej@suse.de>
Subject: Re: [2.6.0-test5]oops inserting PCMCIA card
Date: Tue, 9 Sep 2003 23:01:13 -0700
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <200309081630.19263.fedor@karpelevitch.net> <200309091202.03759.fedor@karpelevitch.net> <20030909201455.K4216@flint.arm.linux.org.uk>
In-Reply-To: <20030909201455.K4216@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309092301.14112.fedor@karpelevitch.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Tue, Sep 09, 2003 at 12:02:03PM -0700, Fedor Karpelevitch wrote:
> > see attachments. I included couple other items in case they may
> > be relevant.
>
> Well, first driver I looked at - ati-agp.  This should fix all the
> AGP drivers.
>
> Linus please apply.  pci_device_id tables can not and must not be
> marked discardable.
>
> diff -ur orig/drivers/char/agp/ati-agp.c
....

thanks. this seems to fix this issue for me. Is there any more direct 
way trigger this bug?

Fedor.
