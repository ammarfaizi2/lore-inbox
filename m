Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293303AbSBYDZc>; Sun, 24 Feb 2002 22:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293304AbSBYDZW>; Sun, 24 Feb 2002 22:25:22 -0500
Received: from [209.250.53.24] ([209.250.53.24]:13576 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S293303AbSBYDZN>; Sun, 24 Feb 2002 22:25:13 -0500
Date: Sun, 24 Feb 2002 21:27:27 -0600
From: Steven Walter <srwalter@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: ext3 and undeletion
Message-ID: <20020224212727.A15097@hapablap.dyn.dhs.org>
Mail-Followup-To: Steven Walter <srwalter@yahoo.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Uptime: 9:23pm  up  7:20,  0 users,  load average: 1.01, 1.05, 1.08
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After unintentionally deleting some file, I noticed what appears to be
an incosistency (or at least a change) in ext3.  Running debugfs and
executing the command "lsdel", I saw no inodes listed since I last ran
the partition as ext2.  Does ext3 not add its deleted inodes to whatever
list ext2 does?  And can this be fixed without compromising the speed or
data-integrity of ext3?
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
He's alive.  He's alive!  Oh, that fellow at RadioShack said I was mad!
Well, who's mad now?
			-- Montgomery C. Burns
