Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267296AbTGOLsj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 07:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267300AbTGOLsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 07:48:39 -0400
Received: from hektor.net.autocom.pl ([213.134.172.184]:30222 "EHLO
	rozeta.rozeta.com.pl") by vger.kernel.org with ESMTP
	id S267296AbTGOLsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 07:48:36 -0400
Message-ID: <3F13ED8A.9000809@rozeta.com.pl>
Date: Tue, 15 Jul 2003 14:03:22 +0200
From: =?ISO-8859-2?Q?=22Pawe=B3_T=2E_Jochym=22?= <jochym@rozeta.com.pl>
Organization: Institute of Nuclear Physics, Cracow, Poland
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030714 Debian/1.3.1-3 StumbleUpon/1.73
X-Accept-Language: pl
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test1 test results (radeonfb and ACPI on thinkpad A30)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a report on my tests of 2.6.0-test1 on ThinkPad A30:

(preempt kernel with quite standard config - I'll post config on request)

- RadeonFB - sort-of works (it was working fine in 2.4.21). It boots, 
detects panel size correctly (1400x1050), switches to fbconsole of 
proper size but the screen is garbage: the contents of each line seams 
to be shifted by some 8-32 pixels (its difficult to tell exactly how 
much). I was able to reset it to proper geometry by "fbset 1600x1200-60" 
command (notice the geometry!) and after that it reports virtual 
resolution 1600x1200 and visable resolution of 1400x1050 and works fine.

- ACPI - I was unable to boot with ACPI turned on. It simply hangs at
very early stage (shows nothing on the console). Notice that this is 
upgraded BIOS/EC machine with corrected ACPI tables - 2.4.21-ac4 with 
ACPI works fine. Any sugestions?

- Other - i've noticed too fast playback in mplayer (by some 10-20%) and
jumping sound/video in xine.

- We will need to put some more documentation on setting this kernel up 
for newbies (I know - later).

The rest is working fine as far as I can tell.

I'll be happy to provide any additional info/conduct more tests. Just 
say so.

Pawel Jochym

