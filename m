Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266643AbUI0Q7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266643AbUI0Q7e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 12:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266813AbUI0Q7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 12:59:34 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:13306 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S266643AbUI0Q7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 12:59:32 -0400
In-Reply-To: 
X-Mailer: roland_patchbomb
Date: Mon, 27 Sep 2004 09:59:29 -0700
Message-Id: <B33qvfouFeHShDoMHJWh26ey96c@topspin.com>
Mime-Version: 1.0
To: greg@kroah.com, linux-kernel@vger.kernel.org
From: Roland Dreier <roland@topspin.com>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH][0/2] [RESEND] Hotplug variable patches
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 27 Sep 2004 16:59:30.0014 (UTC) FILETIME=[5AA5E7E0:01C4A4B3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Resending because this seems to have gotten dropped)

Hi Greg,

When I wanted to implement some environment variables in my hotplug
method, I looked for an example of how to do it.  I noticed two
things: adding values ends up being kind of messy, and the hotplug
method in drivers/usb/core/usb.c is subtly wrong!  These two patches
attempt to fix both of those problems.

Let me know if you don't like the HOTPLUG_ENV_VAR name and want
something different.

If you apply these, I'll send patches to use HOTPLUG_ENV_VAR in net/,
drivers/ieee1394/, etc.

Thanks,
  Roland

