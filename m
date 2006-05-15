Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932387AbWEOMMo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbWEOMMo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 08:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbWEOMMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 08:12:44 -0400
Received: from [202.125.80.34] ([202.125.80.34]:25131 "EHLO
	esnmail.esntechnologies.co.in") by vger.kernel.org with ESMTP
	id S1751452AbWEOMMn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 08:12:43 -0400
Content-class: urn:content-classes:message
Subject: RE: GPL and NON GPL version modules
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Date: Mon, 15 May 2006 17:42:31 +0530
Message-ID: <AF63F67E8D577C4390B25443CBE3B9F7092931@esnmail.esntechnologies.co.in>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: GPL and NON GPL version modules
thread-index: AcZ4GEhbkiB2uUwoSHW7D26f3BYvygAAESwg
From: "Nutan C." <nutanc@esntechnologies.co.in>
To: "Jan Engelhardt" <jengelh@linux01.gwdg.de>
Cc: "linux-kernel-Mailing-list" <linux-kernel@vger.kernel.org>,
       "Fawad Lateef" <fawadlateef@gmail.com>, <jjoy@novell.com>,
       "Mukund JB." <mukundjb@esntechnologies.co.in>, <gauravd.chd@gmail.com>,
       <bulb@ucw.cz>, <greg@kroah.com>, "Shakthi Kannan" <cyborg4k@yahoo.com>,
       "Srinivas G." <srinivasg@esntechnologies.co.in>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

So, if the proprietary code exposes an interface and if the code within
the GPL makes a call to that interface, will the proprietary code become
part of GPL. Please suggest

Regards,
Nutan

-----Original Message-----
From: Jan Engelhardt [mailto:jengelh@linux01.gwdg.de] 
Sent: Monday, May 15, 2006 5:39 PM
To: Srinivas G.
Cc: linux-kernel-Mailing-list; Fawad Lateef; jjoy@novell.com; Nutan C.;
Mukund JB.; gauravd.chd@gmail.com; bulb@ucw.cz; greg@kroah.com; Shakthi
Kannan
Subject: Re: GPL and NON GPL version modules

>
>If I have a module called module A which uses the GPL code and module B
>uses the NON GPL (proprietary) code. If the module A depends on module
>B, is it possible to load these modules?
>
Technically yes.

>Will it be violating any GPL Rules?
>

	[ big IANAL sticker ]

More or less. If my understanding of the GPL is correct, the "combined" 
thing (the kernel machinery, as in: the contents of your RAM) becomes
GPL. 
But since proprietary code involved, it's gets a hell lot more
complicated, 
since, obviously, you can't just GPLize proprietary code of others.



Jan Engelhardt
-- 
