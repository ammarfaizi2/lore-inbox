Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbTISDKe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 23:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbTISDKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 23:10:34 -0400
Received: from main.gmane.org ([80.91.224.249]:2792 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261227AbTISDKb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 23:10:31 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jan Rychter <jan@rychter.com>
Subject: 2.4.22 USB problem (uhci)
Date: Thu, 18 Sep 2003 20:10:48 -0700
Message-ID: <m2znh1pj5z.fsf@tnuctip.rychter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Spammers-Please: blackholeme@rychter.com
User-Agent: Gnus/5.1003 (Gnus v5.10.3) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:9L94+tv+Qxjk3zY1lA5OTH4rNGo=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Upon disconnecting an USB mouse from a 2.4.22, I get

  uhci.c: efe0: host controller halted. very bad

and subsequently, the machine keeps on spinning in ACPI C2 state, never
going into C3, as it should (since the mouse is the only USB device).

If afterwards I do 'rmmod uhci; modprobe uhci', then the machine starts
using the C3 state again.

--J.

