Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271242AbTHCSs3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 14:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271239AbTHCSs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 14:48:29 -0400
Received: from rrcs-sw-24-153-211-171.biz.rr.com ([24.153.211.171]:60113 "EHLO
	wine.com") by vger.kernel.org with ESMTP id S271307AbTHCSgp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 14:36:45 -0400
Date: Sun, 3 Aug 2003 13:36:42 -0500
From: Robert Serphillips <rserphillips@austin.rr.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: agpgart i865PE
Message-Id: <20030803133642.5beea68f.rserphillips@austin.rr.com>
Organization: Home
X-Mailer: Sylpheed version 0.9.0claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There doesn't seem to be agpgart support in the 2.4.21 kernel for this
device.

Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: Unsupported Intel chipset (device id: 2570), you might want
to try agp_try_unsupported=1.
agpgart: no supported devices found.

Using modprobe agpgart agp_try_unsupported=1 seems to work but causes
general instability
during X load/reload on logout from my wm. It is my understanding that
this chipset is supported
in 2.6.x. Is there a backport planned?

-Rob




