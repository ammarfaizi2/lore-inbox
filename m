Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLDUFh>; Mon, 4 Dec 2000 15:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129226AbQLDUF1>; Mon, 4 Dec 2000 15:05:27 -0500
Received: from f102.law9.hotmail.com ([64.4.9.102]:47114 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S129183AbQLDUFV>;
	Mon, 4 Dec 2000 15:05:21 -0500
X-Originating-IP: [128.162.195.84]
From: "Saber Taylor" <aquabrake@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Summary: lost dirs after fsck (also via82cxx works on kt133)
Date: Mon, 04 Dec 2000 19:34:53 -0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F102RQvXlaoY99EXxt500006c0b@hotmail.com>
X-OriginalArrivalTime: 04 Dec 2000 19:34:53.0594 (UTC) FILETIME=[46818FA0:01C05E29]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <F231OceuLyR1mDxJr5D0000c3f6@hotmail.com>

Thanks for the replies.

As for why I ran the devel kernel with important data, I made the
fatal mistake of listening:

Me: "Are you sure it will be ok??!?"
Friend: "No problems. It's rock solid. I've been running it
         for weeks."

The fact that he also overclocks his cpu 300 Mhz should have been a
thermonucleur warning sign.

On a side note, the linux2.4-test10+ via82cxxx (ac97 codec) works
nicely on the kt133 mobo whereas it locks the machine in linux2.2.
Only unusual thing I noticed is that it pauses a few seconds before
letting me change the volume.

--- data recovery ---

Roger Wolff mentioned:
  "Harddisk-recovery.com" is a professional data-recovery service.
  If you put the drive in a Linux system with LOTs of extra disk
space, we can even try to recover your data remotely over the
internet. The costs are 1195 euro per recovery, plus 0.50 euro per
recovered Mb of data.

Barry K. Nathan & Theodore Y. Ts'o reminded me to look in lost+found
and Ted said the URLs were a good place to start.

Sorry I was kinda vague on the details of the corruption (I lost
all my scrollback logs). It did not happen after a crash. I was
noticing weird errors after mounting the drive from a different
OS (I think group inode errors?), so I blindly ran fsck -y on
it. Unfortunately it's a 61 gig 5400 rpm drive, so a plaintext string
search on the partition has been running about two days so far.
debugfs hasn't been helpful so far altho I haven't reviewed the lsdel
inodes yet.

I think at this point I'm going to just save the hd for rainy
days/weeks. Thanks again.


Saber

_____________________________________________________________________________________
Get more from the Web.  FREE MSN Explorer download : http://explorer.msn.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
