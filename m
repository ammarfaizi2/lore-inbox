Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267436AbUGWHr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267436AbUGWHr5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 03:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267439AbUGWHr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 03:47:57 -0400
Received: from web53810.mail.yahoo.com ([206.190.36.205]:59529 "HELO
	web53810.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267436AbUGWHrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 03:47:55 -0400
Message-ID: <20040723074755.95284.qmail@web53810.mail.yahoo.com>
Date: Fri, 23 Jul 2004 00:47:55 -0700 (PDT)
From: Carl Spalletta <cspalletta@yahoo.com>
Subject: RE: [PATCH] remove 55 dead prototypes from include/acpi/acdisasm.h
To: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> -----Original Message-----
>> From: Carl Spalletta [mailto:cspalletta@yahoo.com]
>> Sent: Wednesday, July 21, 2004 3:36 PM
>> To: Moore, Robert; lkml
>> Cc: Brown, Len; acpi-devel@lists.sourceforge.net
>> Subject: RE: [PATCH] remove 55 dead prototypes from include/acpi/acdisasm.h

>>> --- "Moore, Robert" <robert.moore@intel.com> wrote:
>>> These aren't nonexistent functions, they are part of the AML
>>> disassembler (which is not always configured into the kernel)

>> With respect, I cannot find the functions listed below anywhere in
>> the kernel.org kernel.  Where are they?

> --- "Moore, Robert" <robert.moore@intel.com> wrote:
> Subject: RE: [PATCH] remove 55 dead prototypes from include/acpi/acdisasm.h
> Date: Thu, 22 Jul 2004 13:48:12 -0700

> The ACPI CA AML debugger and disassembler haven't been integrated into
> the kernel yet, but development is underway and almost complete.

Yes, it is technically correct to say it "is not always configured into the kernel"
but it would be equally correct, and less misleading to say it is "never configured
into the kernel, because the code is not there".

