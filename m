Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751244AbVJSThF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbVJSThF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 15:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbVJSThF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 15:37:05 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:40113 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1751244AbVJSThD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 15:37:03 -0400
Date: Wed, 19 Oct 2005 21:39:13 +0200
To: linux-kernel@vger.kernel.org
Subject: How to use a USB  SD/MMC card reader?
Message-ID: <20051019193913.GA21749@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an usb card reader (Apacer) in my desktop machine.

It has several slots for different card types. One of the slots accepts
the compactflash cards I use in my camera.  I can mount those and
copy the pictures, no problems there. (It becomes /dev/sdf)

Another slot accepts SD/MMC cards.  I tried inserting an MMC card,
but nothing seems to happen.  Using /dev/sdf doesn't work - no medium.
And /dev/sdg doesn't exist.  

I obviously have usb block devices & scsi working, or I'd be unable to use
the compactflash cards.  I have also enabled CONFIG_MMC for this kernel. (2.6.14-rc3)

Is there anything else I should do, to make the mmc slot work too?

Helge Hafting 
