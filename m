Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbWCVLcz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbWCVLcz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 06:32:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWCVLcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 06:32:55 -0500
Received: from mail1.webmaster.com ([216.152.64.168]:51974 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP
	id S1750780AbWCVLcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 06:32:54 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Cc: <virtualization@lists.osdl.org>, "Ian Pratt" <ian.pratt@xensource.com>,
       <xen-devel@lists.xensource.com>, <linux-kernel@vger.kernel.org>,
       "Chris Wright" <chrisw@sous-sol.org>
Subject: RE: [RFC PATCH 04/35] Hypervisor interface header files.
Date: Wed, 22 Mar 2006 03:32:39 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKOECJKOAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
In-Reply-To: <0ffa39bba1c9a708536286f4bb80d605@cl.cam.ac.uk>
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Wed, 22 Mar 2006 03:29:01 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Wed, 22 Mar 2006 03:29:02 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On 22 Mar 2006, at 08:28, Arjan van de Ven wrote:
>
> >> + * This file may be distributed separately from the Linux kernel, or
> >> + * incorporated into other software packages, subject to the
> >> following license:
> >> + *

> > and what, if any, is the license when distributed with the kernel, as
> > you propose? Right now there doesn't seem to be any at all, and thus it
> > would be undistributable.

> I thought GPLv2 would be implicit. I'll add the short GPL stanza to
> each of the offending source files.

	It seems rather illogical to me to add a GPL stanza. The GPL adds new
rights and imposes requirements on you only if you could get those rights no
other way. Since there is another way, the alternative license, the GPL
requirements would never kick in. Although, as far as I can tell, it doesn't
change or harm anything.

	To be precise, it's like saying "you may use this any way you please, or at
your option, you may use it subject to certain restrictions".

	It would make a difference, however, if your notice was excisable, allowing
someone to change the license to GPL only. However, your notice is not
excisable, so the license (for this file and any future modifications to it)
will perpetually be less restrictive than the GPL and the GPL requirements
can never kick in.

	The license is clearly GPL-compatible so I see no need to change it.

	The only thing I can think of is that someone is concerned about the
hypothetical case where someone modifies this file, compiles it, distributes
the result, and refuses to distribute the source code to this module under
the reasoning that he opted for the license that had no such requirement.
But that fails the giggle test, since he needs the GPL to distribute the
GPL'd portions of the binary and the GPL requires all source to be
distributed. (If I could do that, I could *certainly* add my own code to the
kernel and refuse to deliver the source to it, since my own code is under
any license I want it to be under. And I can't do that.)

	DS


