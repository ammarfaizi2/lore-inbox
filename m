Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261827AbRESPT1>; Sat, 19 May 2001 11:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261834AbRESPTR>; Sat, 19 May 2001 11:19:17 -0400
Received: from unthought.net ([212.97.129.24]:49567 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S261827AbRESPTD>;
	Sat, 19 May 2001 11:19:03 -0400
Date: Sat, 19 May 2001 17:19:01 +0200
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: linux-kernel@vger.kernel.org
Subject: Negative inode-nr ?
Message-ID: <20010519171901.A10204@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello all,

I was investigating a problem we believed we had with our monitoring
software (from sysorb.com), where it failed to report the number of
free and allocated inodes.

However, looking into the problem I found that it's the kernel that's
returning bogus values.

What do you think of this ?
[root]# cat /proc/sys/fs/inode-nr 
157097	-180

The number of free inodes is negative !  I find it hard to believe that
that's correct.

Kernel:  2.4.4 on i686

All filesystems are ext2fs.

If you need more information, let me know.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
