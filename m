Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266637AbTBGQ5N>; Fri, 7 Feb 2003 11:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266627AbTBGQ5M>; Fri, 7 Feb 2003 11:57:12 -0500
Received: from node181b.a2000.nl ([62.108.24.27]:8588 "EHLO ddx.a2000.nu")
	by vger.kernel.org with ESMTP id <S266622AbTBGQ5K>;
	Fri, 7 Feb 2003 11:57:10 -0500
Date: Fri, 7 Feb 2003 18:07:09 +0100 (CET)
From: Stephan van Hienen <raid@a2000.nu>
To: kernel@ddx.a2000.nu
cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: fsck out of memory
In-Reply-To: <Pine.LNX.4.53.0302071555110.718@ddx.a2000.nu>
Message-ID: <Pine.LNX.4.53.0302071800200.1306@ddx.a2000.nu>
References: <Pine.LNX.4.53.0302071555110.718@ddx.a2000.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ok added some swap space (4 gigabyte)

usage was about 2.5GB

till aborted :

d0:  64450554/dev/md0:  64450555/dev/md0:  64450556/dev/md0:
64450557/dev/md0:  64450558/dev/md0:  64450559/dev/md0:  64450560/dev/md0:
64450561/dev/md0:  64450562/dev/md0:  64450563/dev/md0:  64450564/dev/md0:
64450565/dev/md0:  64450566/dev/md0:  64450567/dev/md0:  64450568/dev/md0:
64450569/dev/md0:  64450570/dev/md0:  64450571/dev/md0:  64450572/dev/md0:
64450573/dev/md0:  64450574/dev/md0:  64450575/dev/md0:  64450576/dev/md0:
64450577/dev/md0:  64450578/dev/md0:  64450579/dev/md0:  64450580/dev/md0:
64450581/dev/md0:  64450582/dev/md0:  64450583/dev/md0:  64450584/dev/md0:
64450585/dev/md0:  64450586/dev/md0:  64450587/dev/md0:  64450588/dev/md0:
64450589/dev/md0:  64450590e2fsck: Can't allocate block element

e2fsck: aborted
/dev/md0: 153834/76922880 files (9.3% non-contiguous), 181680730/615381536
blocks

any hints ?
(i really would like to get back a clean fs (with ext3 journal))
