Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261340AbUK0Vgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbUK0Vgr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 16:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261341AbUK0Vgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 16:36:47 -0500
Received: from mail1.webmaster.com ([216.152.64.168]:267 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S261340AbUK0Vgq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 16:36:46 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "Jan Engelhardt" <jengelh@linux01.gwdg.de>
Cc: "Javier Villavicencio" <javierv@migraciones.gov.ar>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: RE: no entropy and no output at /dev/random  (quick question)
Date: Sat, 27 Nov 2004 13:35:58 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKIEKEABAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
In-Reply-To: <41A8D89B.9090909@domdv.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Sat, 27 Nov 2004 13:12:21 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Sat, 27 Nov 2004 13:12:24 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Timer, ok. But network - only if you are in full control of the network
> segment the system is attached to which may be the case for your private
> network but usually you can't predict what network traffic is actually
> going on.

	You would need a lot more than that to predict the TSC value when a packet
is received. All kinds of unpredictable elements get mixed in, such as the
offset between the network's timing source and the processor's as well as
the cache efficiency in getting the networking code running to the point
that it checks the TSC.

	DS


