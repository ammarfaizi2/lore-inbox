Return-Path: <linux-kernel-owner+w=401wt.eu-S964899AbXAJO6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964899AbXAJO6Z (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 09:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964905AbXAJO6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 09:58:24 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:43597 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964899AbXAJO6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 09:58:24 -0500
Message-ID: <45A4FF0D.2090705@garzik.org>
Date: Wed, 10 Jan 2007 09:58:21 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
CC: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: SATA/IDE Dual Mode w/Intel 945 Chipset or HOW TO LIQUIFY a flash
 IDE chip under 2.6.18
References: <45A3FF32.1030905@wolfmountaingroup.com> <45A42385.7090904@garzik.org> <45A42670.703@wolfmountaingroup.com> <45A4325C.9060902@garzik.org> <20070110143919.GH17269@csclub.uwaterloo.ca>
In-Reply-To: <20070110143919.GH17269@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennart Sorensen wrote:
> On Tue, Jan 09, 2007 at 07:25:00PM -0500, Jeff Garzik wrote:
>> Combined mode is a technical term.  Judging from your answers, you are 
>> not using combined mode.
> 
> I would have thought 'sata 3.0 + IDE' sounded a lot like combined mode,
> unless it means seperate sata and ide.

Enhanced mode means separate SATA and PATA.

(I recommend avoiding the "IDE" acronym, it is largely meaningless and 
confusing these days)


>> Judging from your answers, you are not in AHCI mode.
>>
>> Side note:  You should use AHCI if available.  Emulating a PATA 
>> interface for SATA devices is error prone [in the silicon].  AHCI is 
>> native SATA, "enhanced mode" is not.
> 
> I tried setting my sister's new machine to AHCI mode (Asus P5B with 965
> chipset), but I eventually gave up since it also needed windows xp on it
> and I can't for the life of me find an AHCI driver for windows that
> would install.

Um, ok?

We're talking about Linux here.  Linux regularly supports hardware 
before Windows does.  This is nothing new.

	Jeff


