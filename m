Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262423AbTEVPsy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 11:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262706AbTEVPsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 11:48:54 -0400
Received: from pcp02462394pcs.chrchv01.md.comcast.net ([68.33.20.149]:54535
	"EHLO mail.jettisonnetworks.com") by vger.kernel.org with ESMTP
	id S262423AbTEVPsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 11:48:50 -0400
From: "David Lewis" <dlewis@vnxsolutions.com>
To: "Marc-Christian Petersen" <m.c.p@wolk-project.de>,
       <linux-kernel@vger.kernel.org>
Cc: "Erin Britz" <ebritz@vnxsolutions.com>
Subject: RE: [OOPS] kswapd 2.4.20
Date: Thu, 22 May 2003 12:01:40 -0400
Message-ID: <EMEOIBCHEHCPNABJGHGOOEKPCNAA.dlewis@vnxsolutions.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <200305221027.00184.m.c.p@wolk-project.de>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hiya Marc,

Thanks for the pointers to the new VM systems. I changed the kernel over to
2.4.21-rc2-ac2 (has rmap in it, right?) and I am rerunning my tests to see
if that solves the problem.

I agree with Andrea about bugs.. I certainly accept them as a necessary
evil. I tend to get frustrated when faced with something that I dont have
the skill to solve myself however. Especially so when I cant seem to get
pointed in the right direction by anyone. :)

Thanks again for your suggestion, and I will let you know if it works out!

David Lewis
Senior Security Engineer
VNX Solutions, Inc <http://www.vnxsolutions.com>
dlewis@vnxsolutions.com <mailto:dlewis@vnxsolutions.com>
410-459-7428 Cell



-----Original Message-----
From: Marc-Christian Petersen [mailto:m.c.p@wolk-project.de]
Sent: Thursday, May 22, 2003 4:41 AM
To: David Lewis; linux-kernel@vger.kernel.org
Cc: Erin Britz
Subject: Re: [OOPS] kswapd 2.4.20


On Wednesday 21 May 2003 16:45, David Lewis wrote:

Hi David,

> Fourth one sent to list.. Please advise if any other information is
needed.
> A reply would be appreciated even if it is to say that this is the wrong
> place.
> May 21 03:23:50 nicebox kernel: Unable to handle kernel paging request at
> virtual address 938a909e
> May 21 03:23:50 nicebox kernel: Process kswapd (pid: 5,
stackpage=df6d5000)
I really don't know how often I've seen this in recent 2.4 kernels
(.17,.18,.19,.20 (mainstream) and so on).

For me, I use the rmap VM. The problem is eliminated in that tree. Also the
-aa VM does not have that problem.

I am pretty sure Andrea sent a fix for this issue more than once a while ago
to the list cc'ed Marcelo (correct me if I am wrong), but to quote Andrea:
"We are here to fix bugs. If bug fixes are not accepted we can stop right
here
to fix bugs".

ciao, Marc


