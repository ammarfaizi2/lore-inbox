Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266616AbUGUUgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266616AbUGUUgP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 16:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266721AbUGUUgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 16:36:15 -0400
Received: from fmr06.intel.com ([134.134.136.7]:9182 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S266616AbUGUUgH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 16:36:07 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [ACPI] [PATCH] remove 55 dead prototypes from include/acpi/acdisasm.h
Date: Wed, 21 Jul 2004 13:30:29 -0700
Message-ID: <37F890616C995246BE76B3E6B2DBE055017355C4@orsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ACPI] [PATCH] remove 55 dead prototypes from include/acpi/acdisasm.h
thread-index: AcRurkeRMvJHKUvOR82a9pGXCOXApwAsxKEg
From: "Moore, Robert" <robert.moore@intel.com>
To: "Carl Spalletta" <cspalletta@yahoo.com>,
       "lkml" <linux-kernel@vger.kernel.org>
Cc: <en.brown@intel.com>, <acpi-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 21 Jul 2004 20:30:30.0619 (UTC) FILETIME=[90DDEAB0:01C46F61]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These aren't nonexistent functions, they are part of the AML
disassembler (which is not always configured into the kernel)




> -----Original Message-----
> From: acpi-devel-admin@lists.sourceforge.net [mailto:acpi-devel-
> admin@lists.sourceforge.net] On Behalf Of Carl Spalletta
> Sent: Tuesday, July 20, 2004 4:05 PM
> To: lkml
> Cc: en.brown@intel.com; acpi-devel@lists.sourceforge.net
> Subject: [ACPI] [PATCH] remove 55 dead prototypes from
> include/acpi/acdisasm.h
> 
> This patch removes 55 prototypes of nonexistent functions.
> 
> N.B.
>  Due to my inability to cut and paste the tab chars embedded in file
to be
> patched (they are
>  picked up as sequences of spaces), you must either a) 'unexpand
--first-
> only' the enclosed patch
>  to recover the tab chars from the original file, or b) apply with
'patch
> --ignore-whitespace'.
>  The latter option can't hurt since we are only removing lines from
the
> file, not adding.
> 
> Signed-off-by: Carl Spalletta <cspalletta@yahoo.com>
> 
> diff -ru /usr/src/linux-2.6.7-orig/include/acpi/acdisasm.h
> /usr/src/linux-2.6.7-new/include/acpi/acdisasm.h
> --- /usr/src/linux-2.6.7-orig/include/acpi/acdisasm.h   2004-06-15
> 22:19:26.000000000 -0700
> +++ /usr/src/linux-2.6.7-new/include/acpi/acdisasm.h    2004-07-18
> 20:10:42.000000000 -0700
> @@ -86,317 +86,14 @@
>         u32                                 level,
>         void                                *context);
> 
