Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262683AbRFBTAs>; Sat, 2 Jun 2001 15:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262672AbRFBTAh>; Sat, 2 Jun 2001 15:00:37 -0400
Received: from smtpnotes.altec.com ([209.149.164.10]:268 "HELO
	smtpnotes.altec.com") by vger.kernel.org with SMTP
	id <S262665AbRFBTAV>; Sat, 2 Jun 2001 15:00:21 -0400
X-Lotus-FromDomain: ALTEC
From: Wayne.Brown@altec.com
To: Sean Jones <sjones@ossm.edu>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <86256A5F.00682272.00@smtpnotes.altec.com>
Date: Sat, 2 Jun 2001 13:58:58 -0500
Subject: Re: Warning in ac6
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org








Sean Jones <sjones@ossm.edu> on 06/02/2001 01:17:15 PM

To:   Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc:    (bcc: Wayne Brown/Corporate/Altec)

Subject:  Warning in ac6




>Also the file /proc/sys/fs/binfmt_misc seems to be missing on my
>machine. How would I remedy this problem?


To answer one of your questions:  /proc/sys/fs/binfmt_misc is a directory, not a
file.  If you mean that this directory is present but empty, try this:

     mount -t binfmt_misc none /proc/sys/fs/binfmt_misc

and see if the register and status files appear in it.  If the directory isn't
there at all, make certain you have CONFIG_BINFMT_MISC=y in your .config file.

Wayne


