Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267087AbSKSSUG>; Tue, 19 Nov 2002 13:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267086AbSKSSTo>; Tue, 19 Nov 2002 13:19:44 -0500
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:59983 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S267071AbSKSSSX>;
	Tue, 19 Nov 2002 13:18:23 -0500
Message-ID: <3DDA8238.3020307@acm.org>
Date: Tue, 19 Nov 2002 12:26:00 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Alan Cox <alan@redhat.com>
Subject: [PATCH] Version 14 of the IPMI driver
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is yet another release of the IPMI driver for Linux.  This release
cleans up the rather broken locking that was in the driver and fixes the
linux command line parsing so the driver may be properly compiled into the
kernel.  Patches are relative to 2.4.19 and 2.5.48.

It also splits out the NMI handling code.  If you don't care about NMI
watchdog pre-timeouts, you don't need the NMI part of the patch.  It's
hopefully going to be in 2.5 soon, anyway, so it won't matter.

As usual, you can get the drivers from SourceForge.  The home page is 
http://openipmi.sourceforge.net. http://sourceforge.net/projects/openipmi
gets you directly to the page with the info.

Alan, I think this release is ready.

-Corey

PS - In case you don't know, IPMI is a standard for system management, it
provides ways to detect the managed devices in the system and sensors
attached to them.  You can get more information at
http://www.intel.com/design/servers/ipmi/spec.htm.

