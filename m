Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272288AbTGYUTZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 16:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272293AbTGYUTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 16:19:25 -0400
Received: from fmr06.intel.com ([134.134.136.7]:43205 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S272288AbTGYUTP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 16:19:15 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [BUG] linux laptop keyboard problem since 2.5.74
Date: Fri, 25 Jul 2003 13:33:37 -0700
Message-ID: <F760B14C9561B941B89469F59BA3A8470255EEA8@orsmsx401.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BUG] linux laptop keyboard problem since 2.5.74
Thread-Index: AcNNvuQ7Q6u08FL6TrOanafDQNOY8QFLHVaA
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "Warren Turkal" <wturkal@cbu.edu>, <linux-kernel@vger.kernel.org>,
       <acpi-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 25 Jul 2003 20:33:37.0918 (UTC) FILETIME=[06F7F9E0:01C352EC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Warren Turkal [mailto:wturkal@cbu.edu] 
> Something got merged between 2.5.73 and 74 that has messed 
> with my system ever 
> since. Some of the keys that are activated with Fn 
> combinations are messed up.
> 
> Some of these combinations involve turning on external 
> monitor output and 
> showing battery status.
> 
> I suspect ACPI as that was the culprit last time when I could 
> not use the Fn 
> combinations at all. I compiled my kernel with acpi as 
> modules and the 
> problems happens even when not loading the modules for acpi. 
> I also tried 
> booting with acpi=off and that did not seem to change anything.
> 
> Like I said, 2.5.73 was fine and didn't lock like 2.5.74 to 
> 2.6.0-test1 do. So 
> the bug was somewhere in that revision.
> 
> I have a Gateway 600 series laptop with 256mb ram and 1.9Ghz 
> P4. Does anyone 
> know where I should start investigating for more info.

I don't think it's ACPI to blame. The ACPI-related changesets applied
between 2.5.73 and 2.5.74 don't look like the culprit. Also, since it
continues to happen when acpi=off that also points away from ACPI.

I have other reports of things breaking in the same timeframe so I think
it's fair to say that something has regressed...somewhere.

Regards -- Andy
