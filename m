Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268189AbUHVU2L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268189AbUHVU2L (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 16:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268207AbUHVU2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 16:28:11 -0400
Received: from main.gmane.org ([80.91.224.249]:56763 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S268189AbUHVU2G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 16:28:06 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Date: Sun, 22 Aug 2004 22:27:53 +0200
Message-ID: <MPG.1b9320097a2223179896d6@news.gmane.org>
References: <2ptdY-42Y-55@gated-at.bofh.it> <2uPdM-380-11@gated-at.bofh.it> <2uUwL-6VP-11@gated-at.bofh.it> <2uWfh-8jo-29@gated-at.bofh.it> <2uXl0-Gt-27@gated-at.bofh.it> <2vge2-63k-15@gated-at.bofh.it> <2vgQF-6Ai-39@gated-at.bofh.it> <2vipq-7O8-15@gated-at.bofh.it> <2vj2b-8md-9@gated-at.bofh.it> <2vDtS-bq-19@gated-at.bofh.it> <E1ByXMd-00007M-4A@localhost> <412770EA.nail9DO11D18Y@burner> <412889FC.nail9MX1X3XW5@burner> <Pine.LNX.4.58.0408221450540.297@neptune.local> <m37jrr40zi.fsf@zoo.weinigel.se> <4128CAA2.nail9RG21R1OG@burner>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ppp-82-130.29-151.libero.it
X-Newsreader: MicroPlanet Gravity v2.60
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling wrote:
> A powerful CD/DVD recording program needs to sometimes issue "secret"
> and vendor unique SCSI commands in order to give nice features.
> 
> On a Plextor drive, you need to be able to issue a vendor unique SCSI command
> to know the recommended write speed for a specific medium. A SCSI command
> from same list of vendor unique commands allows you to tell the drive to read
> any medium at 52x. This could destroy the medium _and_ the drive.
> 
> As you see: you cannot have the needed knowledge inside the kernel.

Actually I was wondering about this exactly: why shouldn't this 
knowledge be built into the kernel? IMO it should be. Isn't the 
kernel purpose to do that, among other things? HAL?

-- 
Giuseppe "Oblomov" Bilotta

Can't you see
It all makes perfect sense
Expressed in dollar and cents
Pounds shillings and pence
                  (Roger Waters)

