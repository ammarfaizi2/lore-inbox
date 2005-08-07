Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752187AbVHGPdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752187AbVHGPdi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 11:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752188AbVHGPdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 11:33:38 -0400
Received: from fmmailgate07.web.de ([217.72.192.248]:65435 "EHLO
	fmmailgate07.web.de") by vger.kernel.org with ESMTP
	id S1752194AbVHGPdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 11:33:37 -0400
Date: Sun, 07 Aug 2005 17:32:51 +0200
Message-Id: <816070633@web.de>
MIME-Version: 1.0
From: martin.maurer@email.de
To: Martin Maurer <martinmaurer@gmx.at>,
       Alan Stern <stern@rowland.harvard.edu>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, PeteZaitcev <zaitcev@redhat.com>
Subject: Re: Fw: Re: Elitegroup K7S5A + usb_storage problem
Organization: http://freemail.web.de/
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Alan,

no. the stick doesn't have a write protection switch.
Once when i tried to copy a file to the mp3 player i got a new file there on remount,
but it consisted of incorrect data. (so writing seemed to be possible and just went wrong)
(in that case the fat seemed to be damaged after i had tried this, so that windows wasn't 
able to read it correctly any more.
(formatting from the mp3 players menu helped)

greetings
Martin

PS: just as an info - i sent a usbmon trace to Pete Zaitcev today, should I send it to you too? 

Alan Stern <stern@rowland.harvard.edu> schrieb am 07.08.05 17:14:52:
On Sun, 7 Aug 2005, Martin Maurer wrote:

> Hi Pete,
> 
> when using ub with your patch i get a lot further:
> the device is detected and uba+uba1 entries appear.
> I can mount the device correctly.
> Copying the files down and comparing them with the originals gives correct 
> results.
> 
> but:
> when i delete the files which are on the stick and do an umount/mount cycle, 
> the files are there again. 
> Copying files to the stick gives wrong results too.
> Once the created file vanished after the remount,
> and once it was there with a different name/size/date and garbage as content.

It sounds as though the device isn't actually carrying out the write 
operations.  Is it write-protected?

Alan Stern



