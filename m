Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275301AbTHSCEp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 22:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275303AbTHSCEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 22:04:45 -0400
Received: from fmr01.intel.com ([192.55.52.18]:10168 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S275301AbTHSCEn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 22:04:43 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [patch] 2.4.x ACPI updates
Date: Mon, 18 Aug 2003 22:04:39 -0400
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE009FC79@hdsmsx402.hd.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch] 2.4.x ACPI updates
Thread-Index: AcNlzaan7LoRqtYHSvSM/vAmUasnywAIsjXA
From: "Brown, Len" <len.brown@intel.com>
To: "Jeff Garzik" <jgarzik@pobox.com>, "J.A. Magallon" <jamagallon@able.es>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 19 Aug 2003 02:04:41.0539 (UTC) FILETIME=[40860130:01C365F6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The ISO_8859_1 acute accent, u with diaeresis, and registered sign, have been in Config.info since Feb 2002.

Andy's tools seem to have extended them to 16-bit characters during a merge.  A "minor gaff"?  Okay, I guess that's fair.  He promises that he doesn't know how to type a latin capital A with a circumflex on his keyboard;-).

Moving on...  Is the fix to restore the 8-bit characters, or use 7-bit characters?

Thanks,
-Len


> -----Original Message-----
> From: Jeff Garzik [mailto:jgarzik@pobox.com] 
> Sent: Monday, August 18, 2003 5:10 PM
> To: J.A. Magallon
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: [patch] 2.4.x ACPI updates
> 
> 
> J.A. Magallon wrote:
> > On 08.18, Jeff Garzik wrote:
> > 
> >>For those without BK, I have extracted Intel's latest 2.4.x 
> ACPI updates
> >>into patch form:
> >>
> >>ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patchki
ts/2.4/2.4.22-rc2-acpi1.patch.bz2
> 
> 
> The patch has some strange non-ascii chars there:
> - the first hunk changes a don't to a don't (an apostrophe to a non-ascii
>   acute accent...)
> - A für to a fÃ¼r (I see the current fine on a terminal but not the second)
> - Some copyright symbols...
> 
> See the 1st, 3rd and 4th hunks in the changes to Configure.help.


Bug Intel, not me.

I personally think they shouldn't be changing non-ACPI-related 
Configure.help entries at all, and what you point out was one of the 
minor ACPI gaffs I mentioned to Marcelo and Alan.

	Jeff



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
