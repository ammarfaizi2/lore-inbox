Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261188AbVDHXID@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbVDHXID (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 19:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261189AbVDHXID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 19:08:03 -0400
Received: from fmr19.intel.com ([134.134.136.18]:37013 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261188AbVDHXGb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 19:06:31 -0400
x-mimeole: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] Priority Lists for the RT mutex
Date: Fri, 8 Apr 2005 16:05:37 -0700
Message-ID: <F989B1573A3A644BAB3920FBECA4D25A02F64800@orsmsx407>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Priority Lists for the RT mutex
Thread-Index: AcU8jc9XWkIDlbn8TnaFPfBssZFsQgAAWaGA
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: <dwalker@mvista.com>
Cc: "Ingo Molnar" <mingo@elte.hu>, <linux-kernel@vger.kernel.org>,
       <sdietrich@mvista.com>, "Steven Rostedt" <rostedt@goodmis.org>,
       "Esben Nielsen" <simlo@phys.au.dk>
X-OriginalArrivalTime: 08 Apr 2005 23:05:39.0262 (UTC) FILETIME=[7B10DDE0:01C53C8F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Daniel Walker [mailto:dwalker@mvista.com]
>
>> Current tip of development has some issues with conditional variables
>> and broadcasts (requeue stuff) that I need to sink my teeth in. Joe
>> Korty is fixing up a lot of corner cases I wasn't catching, but
>> other than that is doing fine.
>
>You try to get out, and they suck you right back in.

Don't mention it :] That's why I want to get some more people
hooked up to this...so I can move on to do other things :)

>> How long ago since you saw it? I also implemented the futex
redirection
>> stuff we discussed some months ago.
>
>It's been a while since I've seen the fusyn scheduler changes. I have
>the curernt fusyn CVS, I'll take a look at it.

All that stuff is in futex.c; bear in mind what I said at
the confcall, it is just a hacky proof-of-concept--it doesn't
even implement the async interface.

It kind of works, but is not all that solid [last time I tried
the JVMs locked up].

-- Inaky
