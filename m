Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263010AbVCDMvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263010AbVCDMvM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 07:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262999AbVCDMrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 07:47:39 -0500
Received: from tim.rpsys.net ([194.106.48.114]:12208 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S262983AbVCDMmh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 07:42:37 -0500
Message-ID: <01ef01c520b7$94bebf80$0f01a8c0@max>
From: "Richard Purdie" <rpurdie@rpsys.net>
To: "Russell King" <rmk+lkml@arm.linux.org.uk>,
       "Andrew Morton" <akpm@osdl.org>
Cc: <davej@redhat.com>, <torvalds@osdl.org>, <jgarzik@pobox.com>,
       <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org> <20050302230634.A29815@flint.arm.linux.org.uk> <42265023.20804@pobox.com> <Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org> <20050303002733.GH10124@redhat.com> <20050302203812.092f80a0.akpm@osdl.org> <20050304105247.B3932@flint.arm.linux.org.uk> <20050304032632.0a729d11.akpm@osdl.org> <20050304113626.E3932@flint.arm.linux.org.uk>
Subject: Re: RFD: Kernel release numbering
Date: Fri, 4 Mar 2005 12:40:30 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2527
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King:
>> It's very much in an arch maintainer's interest to make sure that
>> cross-compilers are easily obtainable.  Any hints?
>
> I was thinking at the time "great, this is one problem which should be
> solved".  How silly of me.  It seems, yet again, that it comes down to
> a case of "if rmk doesn't do it, it won't get done."  Sad but true.
> Now, why do I keep feeling that I'm being taken advantage of all the
> time?  Could it be the complete lack of productive help from anyone else.

I've found the arm cross compiler generated from openembedded 
(http://openembedded.org) to be very reliable. The big advantage in using oe 
would be that it is in active use so it is always highly likely to generate 
a working compiler. Someone just needs to make it generate a 
toolchain/compiler for external use[1], make it available somewhere and 
advertise the fact its available. Generation of the toolchain could probably 
be almost entirely automated.

Fixes for any problems with compiler would be more than welcome for 
incorporation into oe short term and for submission upstream for "proper" 
fixing.

[1] I think I've seen reference that it can already do this...

Richard 

