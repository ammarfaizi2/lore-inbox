Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315437AbSEUSyx>; Tue, 21 May 2002 14:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315442AbSEUSyw>; Tue, 21 May 2002 14:54:52 -0400
Received: from smtpnotes.altec.com ([209.149.164.10]:49423 "HELO
	smtpnotes.altec.com") by vger.kernel.org with SMTP
	id <S315437AbSEUSyu>; Tue, 21 May 2002 14:54:50 -0400
X-Lotus-FromDomain: ALTEC
From: Wayne.Brown@altec.com
To: linux-kernel@vger.kernel.org
Message-ID: <86256BC0.0067E23B.00@smtpnotes.altec.com>
Date: Tue, 21 May 2002 13:52:08 -0500
Subject: Re: Linux-2.5.17
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Under 2.5.17 there is a problem with gtop 1.0.9.  It opens a window but never
fills in any details; there's just a blank background.  The process becomes
unkillable, even with -9, and although I can do a normal shutdown, the root
partition can't be unmounted because the gtop process is still running and so
fsck is forced on reboot.  There are no oops messages that I can find in any of
the logs.

Actually, this happens with all the most recent 2.5.x kernels.  I'm not sure how
far back it goes, but I believe it was working OK prior to 2.5.8.  (If necessary
I can try to narrow it down further.)  It still works great with 2.4.19-pre8 and
2.4.19-pre8-ac5.


