Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262288AbTFIXOE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 19:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262297AbTFIXOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 19:14:03 -0400
Received: from fmr06.intel.com ([134.134.136.7]:60663 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S262288AbTFIXN6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 19:13:58 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: 2.4.22 timeline was RE: 2.4.21-rc7 ACPI broken
Date: Mon, 9 Jun 2003 16:27:34 -0700
Message-ID: <F760B14C9561B941B89469F59BA3A84725A2E0@orsmsx401.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.4.22 timeline was RE: 2.4.21-rc7 ACPI broken
Thread-Index: AcMu02XJ5DkMiQ1nQUaNOUyWB2RRbgACSFCw
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "Marcelo Tosatti" <marcelo@conectiva.com.br>
Cc: "Grzegorz Jaskiewicz" <gj@pointblue.com.pl>,
       "lkml" <linux-kernel@vger.kernel.org>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Brown, Len" <len.brown@intel.com>,
       "Therien, Guy" <guy.therien@intel.com>
X-OriginalArrivalTime: 09 Jun 2003 23:27:35.0447 (UTC) FILETIME=[B5380270:01C32EDE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Marcelo Tosatti [mailto:marcelo@conectiva.com.br] 
> The main reason I didnt want to merge it was due to its size. 
> Its just too
> big.

Maybe it's just because I am so familiar with it, but while its size is
big, I don't view it as terribly big conceptually. The patch is big
because diff doesn't handle file renames well. Plus, the great majority
of changes are in drivers/acpi. I would think you could basically ignore
all that code, and focus your review on the other bits. I'd be happy to
split that out into a much smaller, easier-to-review patch if that would
help.

> 2.4.22 will be a fast enough release to not piss you off on 
> this, trust
> me.

I'm looking forward to its swift arrival.

Regards -- Andy
