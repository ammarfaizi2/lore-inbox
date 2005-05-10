Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261795AbVEJVCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261795AbVEJVCI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 17:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbVEJU7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 16:59:13 -0400
Received: from fmr18.intel.com ([134.134.136.17]:13190 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261795AbVEJU6q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 16:58:46 -0400
x-mimeole: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 2/4] rt_mutex: add new plist implementation
Date: Tue, 10 May 2005 13:58:22 -0700
Message-ID: <F989B1573A3A644BAB3920FBECA4D25A0338B8B1@orsmsx407>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2/4] rt_mutex: add new plist implementation
Thread-Index: AcVVmKu2UFkPO3eDSHO4+XL8u48HBQACiLMQ
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: <dwalker@mvista.com>
Cc: "Oleg Nesterov" <oleg@tv-sign.ru>, "Ingo Molnar" <mingo@elte.hu>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 10 May 2005 20:58:24.0390 (UTC) FILETIME=[018BDA60:01C555A3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Daniel Walker [mailto:dwalker@mvista.com]
>>
>> So as you say, the best way is wrapping your primitives around. I'd
>> suggest a shorter postfix, something like _prio() or _chkprio().
>
>I still say re-implementation of plist is a waste .. Why re-make the
>wheel when you have a perfectly good starting point .

I don't know *shrug* 

In this case, Oleg's wheel looks simpler than mine and does the
same thing, so why not use it? Simpler is beautiful.

I share the concern, though, of it being fully debugged and stuff,
but being simpler it should be easier to prove it correct.

-- Inaky
