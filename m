Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270406AbTGSRei (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 13:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270407AbTGSRei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 13:34:38 -0400
Received: from jimbo.globalnet.hr ([213.149.32.23]:31410 "EHLO
	jimbo.globalnet.hr") by vger.kernel.org with ESMTP id S270406AbTGSReh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 13:34:37 -0400
Date: Sat, 19 Jul 2003 19:47:15 +0200
From: Danijel Schiavuzzi <danijel.schiavuzzi@pu.htnet.hr>
To: linux-kernel@vger.kernel.org
Subject: ISDN4Linux subsystem
Message-ID: <20030719174715.GA1076@lupus>
Mail-Followup-To: Danijel Schiavuzzi <danijel.schiavuzzi@pu.htnet.hr>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Atlantis
X-Operating-System: Linux lupus.atlantis.int 2.4.20-3-k7 
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've tried to build the 2.6.0-test1 kernel and run it.
It suceeded to compile and boot properly except the isdn4linux subsystem
and the hisax driver which don't get compiled/linked properly.
I've sent a bug report to this list 3 days ago, and also CC-ed to the ISDN 
maintainers and mailing list but none have replied so far.
(it can be found here:
http://www.ussg.iu.edu/hypermail/linux/kernel/0307.2/0230.html)

There are some entries in the BugZilla database about this which can be
found here:

http://bugzilla.kernel.org/buglist.cgi?bug_status=UNCONFIRMED&bug_status=NEW&bug_status=OPEN&bug_status=ASSIGNED&bug_status=REOPENED&field0-0-0=product&type0-0-0=substring&value0-0-0=isdn&field0-0-1=component&type0-0-1=substring&value0-0-1=isdn&field0-0-2=short_desc&type0-0-2=substring&value0-0-2=isdn&field0-0-3=status_whiteboard&type0-0-3=substring&value0-0-3=isdn

None of the workarounds (modifying ksymc.c etc.) don't seem to work for
now (the modules get loaded but don't work etc.)

The question is, has anybody got it working and how? I think it's a
major issue to address in 2.6.0 before it becomes stable.

Regards,

Danijel
