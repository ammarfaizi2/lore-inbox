Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265113AbTLCSsi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 13:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265117AbTLCSsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 13:48:37 -0500
Received: from main.gmane.org ([80.91.224.249]:39074 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265113AbTLCSsg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 13:48:36 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andreas Happe <andreashappe@gmx.net>
Subject: [2.6.0-test10(-mm1)] 8139too vs. 8139cp
Date: Wed, 3 Dec 2003 19:48:14 +0100
Message-ID: <slrnbssbve.16d.andreashappe@flatline.ath.cx>
Reply-To: Andreas Happe <andreashappe@gmx.net>
X-Complaints-To: usenet@sea.gmane.org
User-Agent: slrn/0.9.8.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hardware in question: HP compaq nx7000 (8139c+ network card), using ACPI

With the 8139too driver everything works smooth except a "please use
8139too for increased performance and stability" message on bootup.

At first 8139cp works fine, but the machine freezes after 1-2h without
any accessable oops (I'm running X, there was nothing in the logfiles).
This happened while audio or video playback (i dunno if it's related,
eth0, radeon, uhci-hcd, and intel chipset use the same interrupt).

	--Andreas

