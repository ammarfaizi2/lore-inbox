Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266835AbUG1JJ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266835AbUG1JJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 05:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266845AbUG1JJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 05:09:26 -0400
Received: from dwdmx2.dwd.de ([141.38.3.197]:58953 "HELO dwdmx2.dwd.de")
	by vger.kernel.org with SMTP id S266835AbUG1JIq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 05:08:46 -0400
Date: Wed, 28 Jul 2004 09:08:42 +0000 (GMT)
From: Holger Kiehl <Holger.Kiehl@dwd.de>
X-X-Sender: kiehl@praktifix.dwd.de
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: minyard@acm.org
Subject: IPMI watchdog question
Message-Id: <Pine.LNX.4.58.0407280901330.31636@praktifix.dwd.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Using kernel 2.6.7 with ipmi watchdog compiled in, I have noticed that
when the process writting to /dev/watchdog is killed (-9) the system is
not reset. When I query the BMC to list the SEL it does report:

   Watchdog 2 #0x03 | Timer expired

So the BMC does notice that the timer did expire but no action is taken.
What must I do so it resets my system?

Thanks,
Holger
