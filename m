Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269372AbUJRDwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269372AbUJRDwM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 23:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269373AbUJRDwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 23:52:12 -0400
Received: from fmr12.intel.com ([134.134.136.15]:5832 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S269372AbUJRDwH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 23:52:07 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: High pitched noise from laptop: processor.c in linux 2.6
Date: Mon, 18 Oct 2004 11:51:55 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8405D3BF5B@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: High pitched noise from laptop: processor.c in linux 2.6
Thread-Index: AcSzuw8gItsQDplwR5ew0apjz20N/ABCPc9A
From: "Yu, Luming" <luming.yu@intel.com>
To: "Pavel Machek" <pavel@ucw.cz>, "M" <mru@mru.ath.cx>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 18 Oct 2004 03:51:57.0243 (UTC) FILETIME=[D07A00B0:01C4B4C5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi!
>
>> >> Is there any way to stop this? I googled around and found it had 
>> >> something to do with idle frequency of 1000 Hz in 2.6 
>instead of 100Hz 
>> >> in the 2.4 kernel. I couldn't find much else on this. 
>Hunting around the 
>> >> code didn't help much, I don't know C. 
>> >
>> > Change #define HZ 1000 to #define HZ 100...
>> 
>> ... and lose all the benefits of HZ=1000.  What would happen if one
>> were to set HZ to a higher value, like 10000?

There is a similar issue filed on :
http://bugzilla.kernel.org/show_bug.cgi?id=3406

