Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261662AbVBOJeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbVBOJeU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 04:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbVBOJeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 04:34:20 -0500
Received: from mx2.perftech.si ([195.246.0.30]:517 "EHLO mx2.perftech.si")
	by vger.kernel.org with ESMTP id S261662AbVBOJd7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 04:33:59 -0500
Date: Tue, 15 Feb 2005 10:33:44 +0100
From: "xerces8" <xerces8@butn.net>
To: linux-kernel@vger.kernel.org
Subject: Dummy vt for XFree86 ?
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <WorldClient-F200502151033.AA33440074@butn.net>
X-Mailer: WorldClient 8.0.0f
X-Authenticated-Sender: xerces8@butn.net
X-Spam-Processed: butn.net, Tue, 15 Feb 2005 10:33:48 +0100
	(not processed: message from valid local sender)
X-Return-Path: xerces8@butn.net
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-MDAV-Processed: butn.net, Tue, 15 Feb 2005 10:33:52 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Is there a way to prevent VT switching for XFree86 ?

I have two gfx cards and want to start an X server on the secondary
card, while leaving the VTs on the primary card active.

So I need XFree86 not to allocate and cause a switch to a new VT.
Since I know of no way to make XFree86 do that, I wonder if I can
give XFree86 some fake vt on its command line, like :

X :0 vt_dummy

Is this possible with a 2.6.x series kernel ?

Any other way to prevent X taking away "focus" from the primary card ?

( please ignore any possible issues with the keyboard, that may arise
when having X and text VT active at the same time )

Regards,
David Balazic


