Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbTJJDfX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 23:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbTJJDfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 23:35:23 -0400
Received: from grr-gw250-74.iserv.net ([205.217.66.74]:25729 "EHLO
	killerloop.monochromatic.net") by vger.kernel.org with ESMTP
	id S262427AbTJJDfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 23:35:18 -0400
Message-ID: <3F86282D.5050604@monochromatic.net>
Date: Thu, 09 Oct 2003 23:31:57 -0400
From: Marc Britten <mbritten@monochromatic.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030930 Debian/1.4-5
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: USB scsi emulation error in test7
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

booting up test7 I noticed this issue with USB scsi emulation with my CF 
card reader.  If there is no media in the device it gets stuck on 
spinning up disk, just goes . . . . for some time, minutes perhaps.  
Sticking a CF card in the device immediatly causes it to move on.

This problem is reproducable after bootup by simply removing the device 
and plugging it back in (except it doesn't freeze the system up, during 
the initial bootup it hangs there waiting.)

The device I have is a CF Media-Shuttle, some cheap thing I bought at 
officemax or something like that, never had an issue with it in the past 
(well maybe early 2.4's)


Not on the list, please CC if you need more info, pretty much everything 
is a module, upto and including support for USB itself.

thanks,

Marc Britten

