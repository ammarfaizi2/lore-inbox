Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129259AbQKVNIv>; Wed, 22 Nov 2000 08:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129682AbQKVNIl>; Wed, 22 Nov 2000 08:08:41 -0500
Received: from red.csi.cam.ac.uk ([131.111.8.70]:232 "EHLO red.csi.cam.ac.uk")
	by vger.kernel.org with ESMTP id <S129259AbQKVNIi>;
	Wed, 22 Nov 2000 08:08:38 -0500
From: James A Sutherland <jas88@cam.ac.uk>
To: "Joseph Gooch" <mrwizard@psu.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: ECN causing problems
Date: Wed, 22 Nov 2000 12:37:46 +0000
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <006301c05433$feb8c0c0$0200020a@wizws>
In-Reply-To: <006301c05433$feb8c0c0$0200020a@wizws>
MIME-Version: 1.0
Message-Id: <00112212385001.02632@dax.joh.cam.ac.uk>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2000, Joseph Gooch wrote:
> My RaptorNT 6.5 firewall rejects all connections from my linux box when ECN
> is enabled.  The error is attached.  Perhaps this feature should be disabled
> by default?  Or is there already an option of the sort that i'm missing?  I
> only got the idea to disable it after a search of linux-kernel.

It's a faulty firewall. Have you checked for updates?

> Plz cc me, I"m not on the list.
> 
> Later!
> Joe Gooch
> 
> TCP packet dropped (10.204.186.7->x.x.x.x: Protocol=TCP[SYN 0xc0] Port
> 1255->2401): Bad TCP flags combination (received on interface 192.168.1.1)
> (probable QueSO probe as flags=0xc2)

ECN is NOT a "bad flags combination", RaptorNT is a bad firewall. Upgrade or
replace with something RFC compliant.


James.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
