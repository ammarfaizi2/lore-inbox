Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289748AbSAJWiJ>; Thu, 10 Jan 2002 17:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289747AbSAJWiA>; Thu, 10 Jan 2002 17:38:00 -0500
Received: from svr3.applink.net ([206.50.88.3]:8196 "EHLO svr3.applink.net")
	by vger.kernel.org with ESMTP id <S289746AbSAJWho>;
	Thu, 10 Jan 2002 17:37:44 -0500
Message-Id: <200201102237.g0AMbASr031936@svr3.applink.net>
Content-Type: text/plain; charset=US-ASCII
From: Timothy Covell <timothy.covell@ashavan.org>
Reply-To: timothy.covell@ashavan.org
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
        Nelson Mok <nmok@cse.Buffalo.EDU>
Subject: SCSI ID wars [was:  USB Sandisk SDDR-31 problems in 2.4.9 - 2.4.17]
Date: Thu, 10 Jan 2002 16:33:22 -0600
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SOL.4.30.0201100411100.25549-100000@yeager.cse.Buffalo.EDU> <20020110133534.C21482@one-eyed-alien.net>
In-Reply-To: <20020110133534.C21482@one-eyed-alien.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 January 2002 15:35, Matthew Dharm wrote:
> The "stall at shutdown" is a known problem.  I'm testing a patch now... as
> soon as I see my last patchset incorporated into the kernels, I'll send it
> out for inclusion.
>
> As for the USB device "hiding" your SCSI device... how odd.   I've never
> heard of that before.
>
> Matt

Does it hide your SCSI device or just shift the SCSI IDs such that
/dev/scd0 becomes /dev/scd1?   


And that brings up a question concerning whether there is a defined
way of assigning SCSI IDs.    I'm assume that it's "every driver for
itself".


---
timothy.covell@ashavan.org.
