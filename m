Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbTFJLoH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 07:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262456AbTFJLoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 07:44:07 -0400
Received: from sea2-f56.sea2.hotmail.com ([207.68.165.56]:48389 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262422AbTFJLoB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 07:44:01 -0400
X-Originating-IP: [203.51.24.94]
X-Originating-Email: [redph0enix@hotmail.com]
From: "Red Phoenix" <redph0enix@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: SNARE and C2 auditing under 2.5.x
Date: Tue, 10 Jun 2003 23:57:39 +1200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Sea2-F56iZAtGYkNUTv0001fda1@hotmail.com>
X-OriginalArrivalTime: 10 Jun 2003 11:57:40.0839 (UTC) FILETIME=[7E85D770:01C32F47]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the late reply - I've only just spotted the May 21 thread.

>I may be repeating this question, but is there an effort to brigning
>snare code to 2.5.x?

If people are interested, then definitely!

I'm about 80% of the way through a kernel-patch version of snare, and have 
it working nicely on a 2.4.18 based system. I'm just about to try and 
re-apply the changes to 2.4.20 tonight.

For those that don't know, Snare is a C2-style auditing capability, roughly 
analagous to Solaris BSM, or the Windows EventLog subsystem. Until recently, 
Snare existed as a kernel module that used sys_call_table to overlay 
auditing functionality on a bunch of system calls (yes, I know - it should 
be the 8th deadly sin ;). It's now being retooled as a kernel patch.

I've heard through the grapevine that Snare is a required part of the US DoD 
Common Operating Environment for Linux installations, has been evaluated by 
mitre.org, was one of the apps in the 'use of open source tools in the DoD' 
report that came out a while back, is in use inside the Aussie intelligence 
community (no jokes about contradictions please ;), was recently featured at 
SANS, and is also part of RH Adv Server... so it's probably becoming too 
popular to run as a 'two occasional developers' project - at least for the 
kernel components.

Although I've been working with audit logs on a bunch of systems for 
many-a-year, my kernel experience is limited, so although the RH kernel team 
has helped out in the past, and AC has offered to cast an eye or two over 
the code, it's probably time that we consider including more capable hands 
in the development process - any assistance, or suggestions on the way 
forward, would definitely be welcome!

Regards,

Leigh. (please cc me in replies - Leigh [dot] Purdie at intersectalliance 
DOT com)

.. sorry in advance for any hotmail crud below - front-line spam defence..

_________________________________________________________________
MSN 8 helps eliminate e-mail viruses. Get 2 months FREE*. 
http://join.msn.com/?page=features/virus

