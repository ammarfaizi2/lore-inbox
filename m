Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263182AbUDMDov (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 23:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263252AbUDMDov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 23:44:51 -0400
Received: from usea-naimss2.unisys.com ([192.61.61.104]:784 "EHLO
	usea-naimss2.unisys.com") by vger.kernel.org with ESMTP
	id S263182AbUDMDot convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 23:44:49 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [PATCH] 2.6.5- es7000 subarch update
Date: Mon, 12 Apr 2004 22:44:36 -0500
Message-ID: <452548B29F0CCE48B8ABB094307EBA1C04220150@USRV-EXCH2.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] 2.6.5- es7000 subarch update
Thread-Index: AcQhBmGs5QsrFh58RbCTpLPxYTHehgAACvsw
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Len Brown" <len.brown@intel.com>
Cc: "Andrew Morton" <akpm@osdl.org>, "Martin J. Bligh" <mbligh@aracnet.com>,
       <linux-kernel@vger.kernel.org>, <lse-tech@lists.sourceforge.net>
X-OriginalArrivalTime: 13 Apr 2004 03:44:36.0546 (UTC) FILETIME=[A423FA20:01C42109]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Len,

>The ES7000 sure is a great tester of the over-ride code!

Yes, indeed...

>But I don't like the proposal to selectively invalidate
>existing mp_irqs[] entries.
>I think the proper fix is to parse the over-ride entries before
>filling in the (remaining) identity mappings.  This also gets
>rid of the special case for IRQ2, which would be handled exactly
>like the mappings to < 16 on the ES7000 above.

This is great idea! I know that the patch I suggested was "patching the symptom", not really addressing the cause. I didn't really expect it to be used, mostly just to illustrate the problem.

>Perhaps I should send you a patch you can test on the ES7000,
>since I don't have one of those?

Yes, please send me the patch and I will test it immediately.

>In any case, I'd prefer that proposed patches to this code come
>through me, since it is ACPI specific.

Actually, I was just looking for you, and this is my email to one of my friends, who I think won't get it till tomorrow: "The alternative patch I came up with I think is correct, but looks really ugly.  There are like 3 or 4 places where it can be done, maybe someone could give me a hand to decide where to put the fix. Who is actually in charge of the mpparse and things like that I could cc to?"
:)
Thanks,
--Natalie
