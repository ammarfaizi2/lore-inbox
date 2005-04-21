Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261233AbVDUGT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbVDUGT2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 02:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261916AbVDUGTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 02:19:25 -0400
Received: from ms-smtp-03.texas.rr.com ([24.93.47.42]:58777 "EHLO
	ms-smtp-03-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S261233AbVDUGSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 02:18:46 -0400
Message-ID: <426745BF.4000108@davyandbeth.com>
Date: Thu, 21 Apr 2005 01:18:39 -0500
From: Davy Durham <pubaddr2@davyandbeth.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040804
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Dell D810 Laptop Suspend/Resume
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   I've been trying for the last few days to get my D810 to suspend and 
resume in linux.

I'm doing it from klaptop in kde using Fedora Core 3, but I've now 
compiled my own linux-2.6.12-rc2-mm3 kernel since I've seen some ACPI 
changes going in.

At 2.6.11 it would seem to suspend ok, but when doing the resume it 
would come back and have I/O errors.. causing the computer to freeze for 
a few seconds, then run for a second, then freeze again, etc.. the HDD 
light would stay on solid, and at the tty1 I saw something like "ata1: 
command 0xc8 timeout... I/O error..."  So apparently something isn't 
getting starting back up.  Thinking it might be the HDD not spinning, I 
powered off, but DID hear it spin down.

Running what I compiled,  2.6.12-rc2-mm3, the suspend happens a little 
faster but the resume comes to a blank screen, then immediately reboots 
without any messages that I can see.

I'm very interested in getting this to work and will do whatever someone 
needs to gather information.

I may need to ask basic kernel info questions when asked to do something 
as I haven't done much trouble shooting at this low a level before but 
I'm game.  From googling around this is a problem for many and I would 
like to help resolve it.

Any ideas?

Thanks,
   Davy
