Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129385AbRBVU24>; Thu, 22 Feb 2001 15:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129627AbRBVU2q>; Thu, 22 Feb 2001 15:28:46 -0500
Received: from cvsftp.cotw.com ([208.242.241.39]:57360 "EHLO cvsftp.cotw.com")
	by vger.kernel.org with ESMTP id <S129589AbRBVU23>;
	Thu, 22 Feb 2001 15:28:29 -0500
Message-ID: <3A9592F4.FFCC2236@cotw.com>
Date: Thu, 22 Feb 2001 14:30:12 -0800
From: Scott A McConnell <samcconn@cotw.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: nfs_refresh_inode: inode number mismatch
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am getting NFS errors/warnings

VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 196k freed
nfs_refresh_inode: inode number mismatch
expected (0x806/0x6246a), got (0x806/0x62b48)
                     ^/var/run/utmp
^/var/log/wtmp                        **************
nfs_refresh_inode: inode number mismatch
expected (0x806/0x62b48), got (0x806/0x6246a)
nfs_refresh_inode: inode number mismatch
expected (0x806/0x6246a), got (0x806/0x62b48)
nfs_refresh_inode: inode number mismatch
expected (0x806/0x62b4f), got (0x806/0x6246a)

^/var/run/inetd.pid
*****************
nfs_refresh_inode: inode number mismatch
expected (0x806/0x6246a), got (0x806/0x62b48)
nfs_refresh_inode: inode number mismatch
expected (0x806/0x62b48), got (0x806/0x6246a)
nfs_refresh_inode: inode number mismatch
expected (0x806/0x62b48), got (0x806/0x6246a)
nfs_refresh_inode: inode number mismatch
expected (0x806/0x6246a), got (0x806/0x62b48)
nfs_refresh_inode: inode number mismatch
expected (0x806/0x42d60), got (0x806/0x42d5f)
nfs_refresh_inode: inode number mismatch
expected (0x806/0x6246a), got (0x806/0x62b48)
nfs_refresh_inode: inode number mismatch
expected (0x806/0x6246a), got (0x806/0x62b48)
nfs_refresh_inode: inode number mismatch
expected (0x806/0x6246a), got (0x806/0x62b48)

I am running  RedHat Linux version 2.2.16-3 on  my PC and  Hardhat Linux
version 2.4.0-test5 on my MIPS board. Any thoughts or suggestions?

I saw a discussion start on the ARM list along these lines but I never
saw a solution.

Please CC me at samcconn@cotw.com

Thanks,
Scott


