Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131151AbRCGW7S>; Wed, 7 Mar 2001 17:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131177AbRCGW7J>; Wed, 7 Mar 2001 17:59:09 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:39128 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S131151AbRCGW6z>;
	Wed, 7 Mar 2001 17:58:55 -0500
Importance: Normal
Subject: Kernel upgrading problems, please help...
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3  March 21, 2000
Message-ID: <OFC064046E.71D78FEE-ON85256A08.007C770F@somers.hqregion.ibm.com>
From: "Jie Zhou" <jiezhou@us.ibm.com>
Date: Wed, 7 Mar 2001 17:58:32 -0500
X-MIMETrack: Serialize by Router on D02ML231/02/M/IBM(Release 5.0.6a |January 17, 2001) at
 03/07/2001 05:58:33 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I did an upgrade from  kernel-2.2.16 to the latest version-2.4.2.
During the "make bzImage"step, I got bunch of this warning:
"pasting would not give a valid preprocessing token". then I just ignored
it and after all done
rebooted the linux and got into the new kernel successfully. However, when
I tried to
mount my DVD RAM using the command mount -t udf /dev/hdb /mnt/dvd
(I did choose the support for udf filesystem), the command completed with a
promp appears.but
after the 'busy' light on the DVD catridge gets on, it never gets off any
more, and
the computer froze then. I thought it might be because I haven't unmount
the DVD
, so I restarted the computer and use the 'dmesg' command to see what
happens, then I found a lot of
"Unable to identify CD-ROM Format" messages in it. so I did a 'mount'
command to check whether it's
 mounted or not, and the result shows that the /dev/hdb(which is the DVD on
my computer) is not mounted
yet.So I did the mount -t udf /dev/hdb /mnt/dvd again, same thing happens
again-the computer froze with the DVD light on.
I read in the book "Running Linux", the author said
"If any errors or warnings occur while compiling, you cannot expect the
resulting
kernel to work correctly..." I'm wondering if it's because of the the
warning I got during
the process of compiling the image file-"pasting would not give a valid
preprocessing token"
that the mount command fails.
Any kind of suggestions are appreciated..

-Jie


