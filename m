Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264782AbTIKEOb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 00:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265990AbTIKEOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 00:14:31 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:23914 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S264782AbTIKEOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 00:14:30 -0400
Date: Wed, 10 Sep 2003 21:14:14 -0700
From: Frank Cusack <fcusack@fcusack.com>
To: torvalds@osdl.org, lkml <linux-kernel@vger.kernel.org>
Subject: /proc/beep
Message-ID: <20030910211413.A17000@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

/proc/beep is a kernel tweak that sends beep "signals" to a userspace
process reading the /proc/beep file.  There are one or two of these
modules you can find on the Internet.  In order to support them the
kernel needs to export kd_mksound.

Would a /proc/beep module be accepted into the main tree?  From the
ones I've found, I can understand why they might not be accepted.  But
I'm willing to do the [small amount of] work required to get one looking
like other kernel modules.

If not, could at least kd_mksound be exported by default anyway?  This 
would allow homegrown /proc/beep's to not require any kernel mods.

thx
/fc
