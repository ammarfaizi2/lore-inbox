Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130020AbRCHOEM>; Thu, 8 Mar 2001 09:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130029AbRCHOEB>; Thu, 8 Mar 2001 09:04:01 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:927 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S130020AbRCHODy>;
	Thu, 8 Mar 2001 09:03:54 -0500
Importance: Normal
Subject: 2.4.2 kernel mount crash
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3  March 21, 2000
Message-ID: <OF586830F9.6A70047B-ON85256A09.004D1EC7@somers.hqregion.ibm.com>
From: "Jie Zhou" <jiezhou@us.ibm.com>
Date: Thu, 8 Mar 2001 09:03:27 -0500
X-MIMETrack: Serialize by Router on D02ML231/02/M/IBM(Release 5.0.6a |January 17, 2001) at
 03/08/2001 09:03:28 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Folks,

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

