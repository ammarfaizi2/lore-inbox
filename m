Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267334AbTACAIt>; Thu, 2 Jan 2003 19:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267335AbTACAIt>; Thu, 2 Jan 2003 19:08:49 -0500
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:46402 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S267334AbTACAIs>;
	Thu, 2 Jan 2003 19:08:48 -0500
Message-ID: <3E14D6C7.4050006@mvista.com>
Date: Thu, 02 Jan 2003 18:18:15 -0600
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Alan Cox <alan@redhat.com>
Subject: [PATCH] Version 16 of the IPMI driver
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is yet another release of the IPMI driver for Linux.  This release
cleans up the rather broken locking that was in the driver and fixes the
linux command line parsing so the driver may be properly compiled into the
kernel.  Patches are relative to 2.4.20 and 2.5.54.

This release adds minor bugfixes to the watchdog and fixes for handling 
buggy
hardware. It adds the ability to have the user be notified of a 
pretimeout if
not using NMIs for pretimeout notification.

As usual, you can get the drivers from SourceForge.  The home page is
http://openipmi.sourceforge.net. http://sourceforge.net/projects/openipmi
gets you directly to the page with the info.

-Corey

PS - In case you don't know, IPMI is a standard for system management, it
provides ways to detect the managed devices in the system and sensors
attached to them.  You can get more information at
http://www.intel.com/design/servers/ipmi/spec.htm.

