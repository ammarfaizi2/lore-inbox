Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265817AbUIMDJb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265817AbUIMDJb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 23:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265900AbUIMDJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 23:09:30 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:53105 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S265817AbUIMDJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 23:09:27 -0400
Subject: [PATCH][0/2] Hotplug variable patches
In-Reply-To: 
X-Mailer: roland_patchbomb
Date: Sun, 12 Sep 2004 20:09:25 -0700
Message-Id: <10950449652770@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: greg@kroah.com, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 13 Sep 2004 03:09:25.0857 (UTC) FILETIME=[13462510:01C4993F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

