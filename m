Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264361AbTLKGla (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 01:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264362AbTLKGla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 01:41:30 -0500
Received: from secure.comcen.com.au ([203.23.236.73]:778 "EHLO
	xavier.etalk.net.au") by vger.kernel.org with ESMTP id S264361AbTLKGl2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 01:41:28 -0500
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: asia.support@amd.com
Subject: Re: Fixes for nforce2 hard lockup, apic, io-apic, udma133 covered
Date: Thu, 11 Dec 2003 12:50:53 +1000
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org, AMartin@nvidia.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312111250.53334.ross@datscreative.com.au>
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to draw AMD into the picture using their ask AMD web form
but I think it is broken.

Could asia support please take this seriously and forward it to the appropriate
AMD technical personel. I believe the issue is not restricted to linux but
to any code which executes the same way.

The ask AMD submission follows:

Subject Details:
Possible CPU ERRATA: re: bus disconnect and apic timer interrupt

Greetings:
I and many others have been tracking down a hard lockup problem on linux and 
nforce2 chipset.

Please find continuing discussion including a copy of this submission here:

http://linux.derkeiler.com/Mailing-Lists/Kernel/2003-12/1528.html

My current level of knowledge (best estimate) on the problem is that if a cpu 
disconnect cycle is in progress or has occurred and the local apic timer interrupt
is the trigger to return to a connected state then an undocumented timing
constraint exists. The constraint is that the local apic acknowledge will not be
correctly received by the local apic if it occurs earlier than about 500us 
after the processor continues execution. That is if the processor issues
the ack earlier than 500us after resuming execution then an unrecoverable
hard lockup of the system occurs.

Possible causes include a slow start to the local system bus in relation to
the reconnection of the cpu to the local apic as per earlier model athlon CPU's?
Or system bus connect disconnect signal timing problems with the nforce2 northbridge?

What I would like to know is:

a) Can you please isolate- verify cause assuming you have hardware testing facilities.

b) Does this problem affect all local apic interrupt sources including those which
 have come from an io-apic.

c) Is there is a chipset independent way of finding out if we are coming out of
 a disconnect state prior to issuing the local apic acknowledge. 
 i.e. is there a readable status bit within the processor that we can use to see
 if it is safe to immediately ACK the local apic or if we should wait for 500ns or so.

I have experienced this problem on XP2500 barton and XP2200 thoroughbred cores.
Others have experienced it on other model barton cores. At least 4 makes of
motherboard are involved.

So far it appears to affect all current and pending linux releases for the nforce2 chipsets. 
One could say this relates to a good quantity of potential AMD athlon cpu sales
and bugs with nforce2 and AMD may sour uptake of nforce3 and x64.........

Regards
Ross Dickson.
Director.
Dat's Creative Pty Ltd
Gold Coast
Australia


I don't know if it got through, I received this after the submit button

The page cannot be displayed
There is a problem with the page you are trying to reach and it cannot be displayed.
Please try the following:
Click the Refresh button, or try again later; it does not normally take a long time for an application to restart.
Open the 139.95.253.214 home page, and then look for links to the information you want.
HTTP Error 500-12 Application Restarting
 Internet Information Services
Technical Information (for support personnel)

Background:
 The request cannot be processed while the Web site is restarting. 

More information:
 Microsoft Support 

