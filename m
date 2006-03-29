Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750996AbWC2WdI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996AbWC2WdI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 17:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751067AbWC2WdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 17:33:08 -0500
Received: from ore.jhcloos.com ([64.240.156.239]:41990 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id S1751064AbWC2WdH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 17:33:07 -0500
From: James Cloos <cloos@jhcloos.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Schedule for adding pata to kernel?
In-Reply-To: <442A9A1C.1020004@shaw.ca> (Robert Hancock's message of "Wed, 29
	Mar 2006 08:30:52 -0600")
References: <5SuEq-6ut-39@gated-at.bofh.it> <5TDme-22E-27@gated-at.bofh.it>
	<5UAcC-3bd-3@gated-at.bofh.it> <5UH4o-4RJ-27@gated-at.bofh.it>
	<5UTfA-5uK-17@gated-at.bofh.it> <442A9A1C.1020004@shaw.ca>
Copyright: Copyright 2006 James Cloos
X-Hashcash: 1:23:060329:linux-kernel@vger.kernel.org::O2lQWCCniPOk5t+U:0000000000000000000000000000000016Z7D
X-Hashcash: 1:23:060329:hancockr@shaw.ca::bIS0jeq5wpEwTqP7:0h8F0
Date: Wed, 29 Mar 2006 17:30:31 -0500
Message-ID: <m3acb8eveg.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/23.0.0 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Robert" == Robert Hancock <hancockr@shaw.ca> writes:

JimC> but [I] never managed to determine the CONFIG that used ata_piix rather
JimC> than the old ide drivers.  Each attempt left me with a kernel which
JimC> could not mount its root....

Robert> If you build them into the kernel, it should just work..

Agreed.  It should.

But if I leave in CONFIG_IDE=y, CONFIG_BLK_DEV_PIIX=y I get root on
0x0302 rather than 0x0802 even when I also have CONFIG_SCSI_SATA=y
and CONFIG_SCSI_ATA_PIIX=y.

If the first two are not set then the kernel cannot find anything.

My understanding is that with Alan's patch everything should be
using major 8, and that CONFIG_IDE is no longer required, yes?

-JimC
-- 
James H. Cloos, Jr. <cloos@jhcloos.com>
