Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270501AbTGSGIE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 02:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270502AbTGSGIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 02:08:04 -0400
Received: from cpe-024-165-216-107.midsouth.rr.com ([24.165.216.107]:15232
	"EHLO braindead") by vger.kernel.org with ESMTP id S270501AbTGSGIC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 02:08:02 -0400
From: Warren Turkal <wturkal@cbu.edu>
To: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: [BUG] linux laptop keyboard problem since 2.5.74
Date: Sat, 19 Jul 2003 01:22:57 -0500
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200307182149.58889.wturkal@cbu.edu>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the crosspost, but I didn't get a response originally from the 
acpi-devel list. Also, I am not subscribed to either list. Please CC me on 
replies that should go to me.

Something got merged between 2.5.73 and 74 that has messed with my system ever 
since. Some of the keys that are activated with Fn combinations are messed up.

Some of these combinations involve turning on external monitor output and 
showing battery status.

I suspect ACPI as that was the culprit last time when I could not use the Fn 
combinations at all. I compiled my kernel with acpi as modules and the 
problems happens even when not loading the modules for acpi. I also tried 
booting with acpi=off and that did not seem to change anything.

Like I said, 2.5.73 was fine and didn't lock like 2.5.74 to 2.6.0-test1 do. So 
the bug was somewhere in that revision.

I have a Gateway 600 series laptop with 256mb ram and 1.9Ghz P4. Does anyone 
know where I should start investigating for more info.

Thanks, Warren Turkal
-- 
Treasurer, GOLUM, Inc.
http://www.golum.org

