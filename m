Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262614AbVCDRfH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262614AbVCDRfH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 12:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262943AbVCDRfG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 12:35:06 -0500
Received: from tim.rpsys.net ([194.106.48.114]:3991 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S262614AbVCDReD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 12:34:03 -0500
Message-ID: <039001c520e0$4ea3fbe0$0f01a8c0@max>
From: "Richard Purdie" <rpurdie@rpsys.net>
To: "Russell King" <rmk+lkml@arm.linux.org.uk>
Cc: "Andrew Morton" <akpm@osdl.org>, <davej@redhat.com>, <torvalds@osdl.org>,
       <jgarzik@pobox.com>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org> <20050302230634.A29815@flint.arm.linux.org.uk> <42265023.20804@pobox.com> <Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org> <20050303002733.GH10124@redhat.com> <20050302203812.092f80a0.akpm@osdl.org> <20050304105247.B3932@flint.arm.linux.org.uk> <20050304032632.0a729d11.akpm@osdl.org> <20050304113626.E3932@flint.arm.linux.org.uk> <01ef01c520b7$94bebf80$0f01a8c0@max> <20050304132535.A9133@flint.arm.linux.org.uk>
Subject: Re: RFD: Kernel release numbering
Date: Fri, 4 Mar 2005 17:33:33 -0000
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
> On Fri, Mar 04, 2005 at 12:40:30PM -0000, Richard Purdie wrote:
>> I've found the arm cross compiler generated from openembedded
>> (http://openembedded.org) to be very reliable. The big advantage in using 
>> oe
>> would be that it is in active use so it is always highly likely to 
>> generate
>> a working compiler. Someone just needs to make it generate a
>> toolchain/compiler for external use[1], make it available somewhere and
>> advertise the fact its available. Generation of the toolchain could 
>> probably
>> be almost entirely automated.
>
> I'll only believe it when I see it.  The problem is this "someone"...
> Who's going to forfill that space and produce some results?
>
> Something tells me that we'll be very lucky to get a volunteer, let
> alone see any results.

As an experiment I ran "bitbake meta-sdk" on my copy of openemedded. A while 
later I have these in the deploy directory amongst other things.

http://www.rpsys.net/openzaurus/arm-cross/binutils-cross-sdk-2.15.91.0.2-r5.tar.gz 
(3.8MB)
http://www.rpsys.net/openzaurus/arm-cross/gcc-cross-sdk-3.4.2-r0.tar.gz 
(17.5MB)

"bitbake binutls-cross-sdk" and "bitbake gcc-cross-sdk" are more efficient 
as they won't build all the other things in the sdk.

Generating a cross compiler from oe really is as simple as that. Setting up 
oe in the first place is a bit more tricky but too bad.

An improvement to the current situation might be some instructions and links 
to oe to tell people they can build a toolchain this way. Better still 
someone could run the above commands now and again and upload the files 
somewhere. I don't have anywhere I can host files that size on a permanent 
basis. I possibly could be persuaded to run the commands now and again if 
people were going to use the results. I'm in two minds though as generating 
your own from openembedded isn't difficult. Writing instructions for setting 
up oe to build it may be the best option.

Richard 

