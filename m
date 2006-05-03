Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751097AbWECUwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbWECUwd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 16:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbWECUwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 16:52:32 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:58128 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP
	id S1751097AbWECUwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 16:52:32 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: Compiling C++ modules
Date: Wed, 3 May 2006 13:51:56 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKMEAJLLAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <4458AC69.2050308@rtr.ca>
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Wed, 03 May 2006 13:47:54 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Wed, 03 May 2006 13:47:55 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >In the bad old days, performance was the number one priority because
> >computers were slow and resources were scarce

> And that is still *very much* the case on huge numbers of systems
> running Linux --> Embedded systems <---

	Yes and no. Any embedded system likely to run a full Linux kernel today has
at least ten times the performance and resources of the computers from the
bad old days.

	The majority of embedded systems that run very low-end hardware perform
tasks where performance is not particularly important anyway (microwave
oven, elevator). Those that perform more sophisticated tasks generally have
correspondingly more impressive hardware.

	In my experience, reliability is much more important than performance in
most embedded systems. If C++ results in cleaner and better organized code,
for some particular piece of code, it would be madness to choose C out of
fear that C++ will perform worse. (Of course, that's a big 'if'.)

	In fact, in all the years I developed embedded systems (from industrial
knitting machine controllers to medical devices) I can't remember a single
project where performance was the number one priority, or even a
particularly high one. Feature set, reliability, development cost and time,
ease of use, and the like were typically way ahead of performance. Perhaps
for a router or something like that it would be different. But I do not
believe that embedded systems in general are a class where performance is
more important than elsewhere.

	There are small embedded operating systems that are written primarily in
C++.

	DS


