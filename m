Return-Path: <linux-kernel-owner+w=401wt.eu-S1161304AbXAHOOz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161304AbXAHOOz (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 09:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161310AbXAHOOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 09:14:55 -0500
Received: from [213.91.220.177] ([213.91.220.177]:56746 "EHLO
	workshop.bgservice.net" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1161304AbXAHOOy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 09:14:54 -0500
X-Greylist: delayed 1870 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Jan 2007 09:14:54 EST
From: "Dimitar G. Katerinski" <dgk@tropot.net>
To: linux-kernel@vger.kernel.org
Subject: IDE discovered as SATA - 2.6.20-rc4
Date: Mon, 8 Jan 2007 15:44:43 +0200
User-Agent: KMail/1.9.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701081544.43153.dgk@tropot.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry if I'm duplicating the issue, but I've searched the list and didn't find 
a similar report. I've just compiled 2.6.20-rc4 and I have trouble booting. 
After some investigation, I find out that my IDE chipset is being discovered 
as SATA, so my hard drive is not /dev/hda, but /dev/sda. When I passed the 
correct root=/dev/sdaX option to the kernel, it booted fine and everything 
seems to be working. But it puzzles me why, this motherboard doesn't even 
have a SATA chipset. Is this abug or a new feature? :) My IDE chipset is:

00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2)

Regards,
DImitar G. Katerinski
-- 
http://tropot.net/photoblog/ - my life. in pictures.
