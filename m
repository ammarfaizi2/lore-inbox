Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276813AbRJHIF4>; Mon, 8 Oct 2001 04:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276814AbRJHIFq>; Mon, 8 Oct 2001 04:05:46 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:30738 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S276813AbRJHIFh>; Mon, 8 Oct 2001 04:05:37 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15297.24061.128383.739430@beta.reiserfs.com>
Date: Mon, 8 Oct 2001 12:04:13 +0400
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Reiserfs mail-list <Reiserfs-List@Namesys.COM>
Subject: Re: Problem with reiserfs 3.5.34 under 2.2.19
In-Reply-To: <20011006122640.271536fe.skraw@ithnet.com>
In-Reply-To: <20011006122640.271536fe.skraw@ithnet.com>
X-Mailer: VM 6.89 under 21.4 (patch 3) "Academic Rigor" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan von Krawczynski writes:
 > Hello,
 > 
 > I had some serious crash today originated by a reiserfs 3.5.32 on 2.2.19 which
 > panic'd telling me something with inodes is wrong. Unfortunately the msg was
 > only to see on the screen and I didn't write it down. So I decided to update to
 > 3.5.34 and give it a try, again. Now I see the following during normal
 > operation:

Are you using "heather" box as NFS server (with knfsd)?

 > 
 > Oct  6 12:14:05 heather kernel: vs-13048: reiserfs_iget: key in inode [0 68965
 > 0
 >  0] and key in entry [3 68965 0 0] do not match
 > Oct  6 12:14:18 heather last message repeated 25 times
 > Oct  6 12:14:19 heather kernel: vs-13048: reiserfs_iget: key in inode [0 13612
 > 0
 >  0] and key in entry [13609 13612 0 0] do not match
 > Oct  6 12:14:21 heather kernel: vs-13048: reiserfs_iget: key in inode [0 68965
 > 0
 >  0] and key in entry [3 68965 0 0] do not match
 > Oct  6 12:14:48 heather last message repeated 55 times
 > Oct  6 12:15:29 heather last message repeated 14 times
 > Oct  6 12:16:29 heather last message repeated 8 times
 > Oct  6 12:17:42 heather last message repeated 5 times
 > Oct  6 12:18:19 heather kernel: vs-13048: reiserfs_iget: key in inode [0 13612
 > 0
 >  0] and key in entry [13609 13612 0 0] do not match
 > Oct  6 12:18:29 heather kernel: vs-13048: reiserfs_iget: key in inode [0 68965
 > 0
 >  0] and key in entry [3 68965 0 0] do not match
 > 
 > What does this mean? What should be done? Does this fs survive, or am I to
 > reformat?

Take latest reiserfsprogs (3.x.0k-pre10) from ftp.namesys.com, compile
them, run its reiserfsck --check /device and send results to
Reiserfs-list (CCed in this message).

 > 
 > Regards,
 > Stephan

Nikita.

 > -
