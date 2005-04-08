Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262662AbVDHDGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262662AbVDHDGb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 23:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262664AbVDHDGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 23:06:31 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:14351 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S262662AbVDHDG1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 23:06:27 -0400
From: "David Schwartz" <davids@webmaster.com>
To: <linux-kernel@vger.kernel.org>, <debian-legal@lists.debian.org>,
       <linux-acenic@sunsite.dk>
Subject: RE: non-free firmware in kernel modules, aggregation and unclear copyright notice.
Date: Thu, 7 Apr 2005 20:05:31 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKIEAEDAAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
In-Reply-To: <87is2ydnmk.fsf@kreon.lan.henning.makholm.net>
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Thu, 07 Apr 2005 20:04:40 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Thu, 07 Apr 2005 20:04:42 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > No-one is saying that the linker "merely aggregates" object
> > code for the driver; what *is* being said is: in the case of
> > firmware, especially if the firmware is neither a derivative
> > work on the kernel (see above) nor the firmware includes part
> > of the kernel (duh), it is *fairly* *safe* to consider the
> > intermixing of firmware bytes with kernel binary image bytes
> > in an ELF object file as mere aggregation.

> No, it is completely wrong to say that the object file is merely an
> aggregation. The two components are being coupled much more tightly
> than in the situation that the GPL discribes as "mere aggregation".

        Would you maintain this position even if the firmware is identical
across operating systems and the Linux driver is identical across different
firmware builds for different hardware implementations?

        Say, for example, Intel comes out with a new super-smart and
sophisticated network card. They also offer firmware that makes it look just
like an NE2000. They don't create this firmware for Linux, they create it
for any set of operating systems that don't have specific drivers for this
card.

        Similarly, the NE2000 driver wasn't specifically designed to use
this firmware. Both the firmware and the driver were independently developed
to implement the same de facto standard.

        Now, someone combines the firmware and the driver into a package
that checks what card you are using, and if it has the appropriate firmware
to make the card work with the driver, uploads it.

        Note that the issue is not whether the GPL describes this as "mere
aggregation" because the GPL doesn't get to set its own scope. The issue is
whether the resulting binary is a single work (that is derivative of the
GPL'd driver) or whether it's two works with a license boundary between
them.

        It would not be obviously unreasonable to argue that the NE2000 API
constitutes a license boundary between the two works, each of which stays on
its own side of that API.

        Lacking clear court guidance, I see it as a threshold issue. One
primary issue (I think) is to what extent that firmware and the driver have
been customized for each other. A work that is carefully designed to mesh
tightly with another work is analogous to a sequel, which is a derivative
work.

        I think we have a real problem, however, in cases where the source
file that holds only the firmware data contains a GPL notice.

        DS


