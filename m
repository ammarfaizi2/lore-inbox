Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262976AbTESVLh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 17:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262984AbTESVLg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 17:11:36 -0400
Received: from fmr02.intel.com ([192.55.52.25]:4606 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S262976AbTESVLc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 17:11:32 -0400
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E5024136210@orsmsx404.jf.intel.com>
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: linux-kernel@vger.kernel.org, "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Carbonari, Steven" <steven.carbonari@intel.com>
Subject: RE: RFC Proposal to enable MSI support in Linux kernel
Date: Mon, 19 May 2003 14:22:52 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
content-class: urn:content-classes:message
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C31E4C.CF410B00"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C31E4C.CF410B00
Content-Type: text/plain;
	charset="iso-8859-1"

Here is a patch containing the vector-based indexing part only.

Thanks,
Tom



-----Original Message-----
From: Zwane Mwaikambo [mailto:zwane@linuxpower.ca]
Sent: Wednesday, May 14, 2003 12:54 PM
To: Nakajima, Jun
Cc: Nguyen, Tom L; linux-kernel@vger.kernel.org; Saxena, Sunil; Mallick,
Asit K; Carbonari, Steven
Subject: RE: RFC Proposal to enable MSI support in Linux kernel


On Wed, 14 May 2003, Nakajima, Jun wrote:

> That's a good idea, and that's the way we did this (we added MSI 
> support on top of the vector-based indexing). If people are interested in 
> the vector-based indexing (i.e. provide the vector number to device 
> drivers (non-legacy drivers only) instead of IRQ) for some other uses, we 
> would like to discuss possible cleaner implementations.
> 
> Long will post a patch containing the vector-based indexing part only. 

Thanks! It'd be a lot easier to test the core changes too. What do you 
mean by non legacy?

	Zwane
-- 
function.linuxpower.ca


------_=_NextPart_000_01C31E4C.CF410B00
Content-Type: application/x-gzip;
	name="linux-2.5.65-vector-base-20030515.patch.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="linux-2.5.65-vector-base-20030515.patch.gz"

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
PGZ7Dp//BTGKC5l4IAAA

------_=_NextPart_000_01C31E4C.CF410B00--
