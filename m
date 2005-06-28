Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbVF1Vrv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbVF1Vrv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 17:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261370AbVF1Vpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 17:45:41 -0400
Received: from fmr13.intel.com ([192.55.52.67]:36041 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S261301AbVF1Vnv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 17:43:51 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: C2/C3 on SMP [Was: Re: 2.6.X not recognizing second CPU]
Date: Tue, 28 Jun 2005 17:43:35 -0400
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3003F0720B@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: C2/C3 on SMP [Was: Re: 2.6.X not recognizing second CPU]
Thread-Index: AcV8KGtX8+0Fq0MeRfqpIkkQJjRVgQAAe+iw
From: "Brown, Len" <len.brown@intel.com>
To: "Dominik Brodowski" <linux@dominikbrodowski.net>,
       "Erik Slagter" <erik@slagter.name>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: "Andrew Haninger" <ahaning@gmail.com>,
       "Jim serio" <jseriousenet@gmail.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 28 Jun 2005 21:43:37.0689 (UTC) FILETIME=[710A2C90:01C57C2A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, this patch, and some other acpi patches, should re-join mm and
linus tree momentarily...

-----Original Message-----
From: Dominik Brodowski [mailto:linux@dominikbrodowski.net] 
Sent: Tuesday, June 28, 2005 5:29 PM
To: Erik Slagter; Pallipadi, Venkatesh; Brown, Len
Cc: Andrew Haninger; Jim serio; linux-kernel@vger.kernel.org
Subject: C2/C3 on SMP [Was: Re: 2.6.X not recognizing second CPU]

On Tue, Jun 28, 2005 at 01:32:59PM +0200, Erik Slagter wrote:
> On Mon, 2005-06-27 at 23:42 +0200, Dominik Brodowski wrote:
> > a) Power Management is available on SMP, though support for it is a
bit less
> >    wide-spread than it is for UP
> 
> Still no C2/C3 handling :-(

Uh, wasn't there a small, nice patch implementing this in bk-acpi a few 
weeks ago?
*clicketyclick* Oh yes,
http://bugzilla.kernel.org/show_bug.cgi?id=4401
states it was merged into bk-acpi-test on 2005-04-22. However, I can't
find
it in current -mm any more...

	Dominik
