Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136225AbRDVRW4>; Sun, 22 Apr 2001 13:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136227AbRDVRWr>; Sun, 22 Apr 2001 13:22:47 -0400
Received: from leng.mclure.org ([64.81.48.142]:56324 "EHLO
	leng.internal.mclure.org") by vger.kernel.org with ESMTP
	id <S136225AbRDVRWg>; Sun, 22 Apr 2001 13:22:36 -0400
Date: Sun, 22 Apr 2001 10:22:34 -0700
From: Manuel McLure <manuel@mclure.org>
To: linux-kernel@vger.kernel.org
Subject: Problem with "su -" and kernels 2.4.3-ac11 and higher
Message-ID: <20010422102234.A1093@ulthar.internal.mclure.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.1.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having a problem with "su -" on ac11/ac12. ac5 doesn't show the
problem.
The problem is easy to reproduce - go to a console, log in as root, do an
"su -" (this will succeed) and then another "su -". The second "su -"
should hang - ps shows it started bash and that the bash process is
sleeping. You need to "kill -9" the bash to get your prompt back.

Distribution is Red Hat 7.1, running on an Athlon Thunderbird 900MHz on a
MSI K7T Turbo R motherboard.

Thanks,
-- 
Manuel A. McLure KE6TAW | ...for in Ulthar, according to an ancient
<manuel@mclure.org>     | and significant law, no man may kill a cat.
<http://www.mclure.org> |             -- H.P. Lovecraft

