Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314083AbSE2R0L>; Wed, 29 May 2002 13:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314138AbSE2R0K>; Wed, 29 May 2002 13:26:10 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:57614
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S314083AbSE2R0J>; Wed, 29 May 2002 13:26:09 -0400
Date: Wed, 29 May 2002 10:26:16 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Processes stuck in D state with autofs + smbfs
Message-ID: <20020529172616.GB1136@matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been having a recurring problem ever since the 2.2 kernel days between
smbfs and autofs.

I'm currently running 2.4.19-pre6-vm33 on this 2x664Mhz P3 machine, but I've
also had the problem in the previous UP machine.

I'm not sure what information will be helpful in debugging this probem.
Would sysrq+t run through ksymoops be helpful?

I also have this in my kernel log:
May 26 06:33:16 fileserver kernel: Uhhuh. NMI received. Dazed and confused, but trying to continue
May 26 06:33:16 fileserver kernel: You probably have a hardware problem with your RAM chips

I did a quick search and it looks like this might be a memory parity error.
Right now this system runs the scripts that triggers the condition, but I
can do tests on a different machine.

Is there anyone interested in this problem?

Oh, I'm running debian and the samba packages are:
ii  samba                  2.2.3a-6               A LanManager like file and printer server for Unix.
ii  smbfs                  2.2.3a-6               mount and umount commands for the smbfs (for kernels >= than

Thanks,

Mike
