Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276578AbRI2Sbt>; Sat, 29 Sep 2001 14:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276581AbRI2Sbk>; Sat, 29 Sep 2001 14:31:40 -0400
Received: from femail24.sdc1.sfba.home.com ([24.0.95.149]:22145 "EHLO
	femail24.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S276578AbRI2Sba>; Sat, 29 Sep 2001 14:31:30 -0400
Message-ID: <3BB61365.F54C3A2@home.com>
Date: Sat, 29 Sep 2001 14:31:01 -0400
From: John Gluck <jgluckca@home.com>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: fam & imon
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I've been looking at the fam and imon stuff at
http://oss.sgi.com/projects/fam/
It seems to be something that can be quite useful.

Is thare a reason why this is not part of the kernel?

Is there an imon patch that can be used with the 2.4.10 kernels?

I looked at imon for the 2.4.0 kernel and it seem to be a set of new
files plus a patch to linux/fs/namei.c
namei.c has changed since the 2.4.0 kernel so the patch won't work. I
did try to isolate what need to be done and found that I could get it to
compile by adding an include of a header file. The problem is that doing
this seems to break the iptables stuff.

Any help appreciated

John

