Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262874AbVGHVtA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262874AbVGHVtA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 17:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262856AbVGHVrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 17:47:12 -0400
Received: from sb0-cf9a48a7.dsl.impulse.net ([207.154.72.167]:3342 "EHLO
	madrabbit.org") by vger.kernel.org with ESMTP id S262871AbVGHVpP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 17:45:15 -0400
Subject: excessive IDE log spamming
From: Ray Lee <ray-lk@madrabbit.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: http://madrabbit.org/
Date: Fri, 08 Jul 2005 14:45:13 -0700
Message-Id: <1120859114.10563.35.camel@orca.madrabbit.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ray:/var/log$ grep ' 08:' messages
Jul  8 08:00:00 orca kernel: [7033724.854000] hdc: ATAPI reset complete
Jul  8 08:00:00 orca kernel: [7033724.854000] hdc: status error: status=0x20 { DeviceFault }
Jul  8 08:00:00 orca kernel: [7033724.854000] ide: failed opcode was: unknown
Jul  8 08:00:00 orca kernel: [7033724.904000] hdc: ATAPI reset complete
Jul  8 08:00:00 orca kernel: [7033724.904000] hdc: status error: status=0x20 { DeviceFault }
Jul  8 08:00:00 orca kernel: [7033724.904000] ide: failed opcode was: unknown
Jul  8 08:00:00 orca kernel: [7033724.904000] hdc: status error: status=0x20 { DeviceFault }
Jul  8 08:00:00 orca kernel: [7033724.904000] ide: failed opcode was: unknown
Jul  8 08:00:00 orca kernel: [7033724.954000] hdc: ATAPI reset complete
Jul  8 08:00:00 orca kernel: [7033724.954000] hdc: status error: status=0x20 { DeviceFault }
Jul  8 08:00:00 orca kernel: [7033724.954000] ide: failed opcode was: unknown
Jul  8 08:00:00 orca kernel: [7033725.004000] hdc: ATAPI reset complete
Jul  8 08:00:00 orca kernel: [7033725.004000] hdc: status error: status=0x20 { DeviceFault }
Jul  8 08:00:00 orca kernel: [7033725.004000] ide: failed opcode was: unknown
Jul  8 08:00:02 orca kernel: [7033727.006000] hdc: status error: status=0x20 { DeviceFault }

/var/log/{messages,syslog,kern.log} are each growing at about 4
megabytes an hour. That's nearly a third of a gig per day. I may be a
bit dense, but honest, I got the hint the first meg.

/dev/hdc points to my Plextor CD/RW drive. I'm not sure when this
started; it took some time before I noticed my hard drive filling up
(they're pretty big these days). I'll be rebooting here soon, which I
imagine will fix the problem.

Using Ubuntu's 2.6.12 kernel, so there's the outside chance that odd
vendor patches are doing unhappy things.

Ray

