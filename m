Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268933AbUIHIKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268933AbUIHIKZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 04:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268928AbUIHIKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 04:10:25 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:13965 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S268937AbUIHIKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 04:10:19 -0400
From: Lorenzo Allegrucci <l_allegrucci@yahoo.it>
Organization: -ENOENT
To: Nathan Bryant <nbryant@optonline.net>
Subject: Re: 2.6.9-rc1-mm4
Date: Wed, 8 Sep 2004 10:15:00 +0200
User-Agent: KMail/1.7
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Bjorn Helgaas <bjorn.helgaas@hp.com>
References: <20040907020831.62390588.akpm@osdl.org> <200409072201.55025.l_allegrucci@yahoo.it> <413E18CB.7020305@optonline.net>
In-Reply-To: <413E18CB.7020305@optonline.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409081015.00114.l_allegrucci@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 September 2004 22:23, Nathan Bryant wrote:
> Lorenzo Allegrucci wrote:
> > On Tuesday 07 September 2004 11:08, Andrew Morton wrote:
> >>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2
> >>.6 .9-rc1-mm4/
> >
> > My PS/2 keyboard doesn't work, I tried "pci=routeirq" but it didn't help.
> >
> > Sep  7 21:39:00 odyssey kernel: i8042: ACPI  [PS2K] at I/O 0x0, 0x0, irq
> > 1 Sep  7 21:39:00 odyssey kernel: i8042: ACPI  [PS2M] at irq 12
> > Sep  7 21:39:00 odyssey kernel: i8042.c: Can't read CTR while
> > initializing i8042.
>
> Try i8042.noacpi on the kernel command line

i8042.noacpi=1 fixed it, thanks.

-- 
Lorenzo
