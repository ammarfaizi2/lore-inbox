Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275121AbRJFK0g>; Sat, 6 Oct 2001 06:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275119AbRJFK0Z>; Sat, 6 Oct 2001 06:26:25 -0400
Received: from ns.ithnet.com ([217.64.64.10]:20228 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S275117AbRJFK0V>;
	Sat, 6 Oct 2001 06:26:21 -0400
Date: Sat, 6 Oct 2001 12:26:40 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Problem with reiserfs 3.5.34 under 2.2.19
Message-Id: <20011006122640.271536fe.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I had some serious crash today originated by a reiserfs 3.5.32 on 2.2.19 which
panic'd telling me something with inodes is wrong. Unfortunately the msg was
only to see on the screen and I didn't write it down. So I decided to update to
3.5.34 and give it a try, again. Now I see the following during normal
operation:

Oct  6 12:14:05 heather kernel: vs-13048: reiserfs_iget: key in inode [0 68965
0
 0] and key in entry [3 68965 0 0] do not match
Oct  6 12:14:18 heather last message repeated 25 times
Oct  6 12:14:19 heather kernel: vs-13048: reiserfs_iget: key in inode [0 13612
0
 0] and key in entry [13609 13612 0 0] do not match
Oct  6 12:14:21 heather kernel: vs-13048: reiserfs_iget: key in inode [0 68965
0
 0] and key in entry [3 68965 0 0] do not match
Oct  6 12:14:48 heather last message repeated 55 times
Oct  6 12:15:29 heather last message repeated 14 times
Oct  6 12:16:29 heather last message repeated 8 times
Oct  6 12:17:42 heather last message repeated 5 times
Oct  6 12:18:19 heather kernel: vs-13048: reiserfs_iget: key in inode [0 13612
0
 0] and key in entry [13609 13612 0 0] do not match
Oct  6 12:18:29 heather kernel: vs-13048: reiserfs_iget: key in inode [0 68965
0
 0] and key in entry [3 68965 0 0] do not match

What does this mean? What should be done? Does this fs survive, or am I to
reformat?

Regards,
Stephan
