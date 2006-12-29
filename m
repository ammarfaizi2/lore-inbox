Return-Path: <linux-kernel-owner+w=401wt.eu-S1754896AbWL2Qt6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754896AbWL2Qt6 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 11:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754985AbWL2Qt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 11:49:58 -0500
Received: from mailtir.platform.com ([192.219.104.248]:62180 "EHLO
	mailtir.platform.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754896AbWL2Qt6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 11:49:58 -0500
X-Greylist: delayed 1465 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Dec 2006 11:49:57 EST
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: [2.6.19] Scheduler starvation of audio?
Date: Fri, 29 Dec 2006 11:25:22 -0500
Message-ID: <E2AC825D4FC7764DA86D9C8ECA27A2DE065B14@catoexm05.noam.corp.platform.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.6.19] Scheduler starvation of audio?
Thread-Index: AccrZgwIkBPezzvGTJ2sUomwlz4TjQ==
From: "Shawn Starr" <sstarr@platform.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

If any of you have used a Commodore 64 emulator in Linux (such as vice) noticed when using audio there is severe starvation while other activities of the system are going on. i.e.  moving a window in X or starting another application causing audio to chop (this goes away if you speed up the emulation to 200% then drop it back down to 100% The audio will resume chopping once you perform more activity on the desktop). Note, even increasing the audio buffer of the emulation app to its maximum does not help. Of note, the machine I ran this emulator on had a low load.

There are times when I hit starvation and I wonder if there's any interesting scheduler patches in -mm that might address this?

Thanks,

--
Shawn Starr
Software Developer, Open Source Grid Development Center (OSGDC)
Platform Computing
3760 14th Avenue
Markham, ON L3R3T7
direct: 905.948.4229
http://www.platform.com

