Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131148AbRAHUFD>; Mon, 8 Jan 2001 15:05:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130580AbRAHUEn>; Mon, 8 Jan 2001 15:04:43 -0500
Received: from f175.law8.hotmail.com ([216.33.241.175]:27148 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S131148AbRAHUEa>;
	Mon, 8 Jan 2001 15:04:30 -0500
X-Originating-IP: [170.148.65.7]
From: "Jason Perlow" <perlow@hotmail.com>
To: ilh@sls.lcs.mit.edu
Cc: redhat-list@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Adaptec 19160 Problems
Date: Mon, 08 Jan 2001 20:04:24 
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F1757dcLdZs3JcXu98s00012935@hotmail.com>
X-OriginalArrivalTime: 08 Jan 2001 20:04:24.0294 (UTC) FILETIME=[32623060:01C079AE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So you are saying this was fixed in 2.2.18? Which distro uses that by 
default now?

We need to get the distros to come up with boot floppy images for this then 
because 19160 is a very popular host adapter. Its not like its weirdo 
hardware. Waiting for an updated distro is a real pain in the ass if this 
can be fixed easily by just updating the boot disk images.

Jason


From: I Lee Hetherington <ilh@sls.lcs.mit.edu>
To: Jason Perlow <perlow@hotmail.com>
Subject: Re: Adaptec 19160 Problems
Date: Mon, 08 Jan 2001 14:45:26 -0500

Well, 2.2.18 is newer than what Red Hat 6.2 installer uses.

You could use Ghost or Drive Image to copy things over, or if you can
mount both simultaneously (booted from IDE), you can just make your SCSI
partition and cp -a everything over.  That is, everything except for
/lost+found, /proc, and any other mount points.

I agree this is ugly, but what can you do when the Red Hat (or
otherwise) install kernel doesn't really support your hardware?
I suppose it is possible to update the install kernel or specific
modules, and I think I once succeeded in doing this, but it is even
uglier!

--Lee


_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
