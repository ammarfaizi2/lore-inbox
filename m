Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261621AbVDWQqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261621AbVDWQqT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 12:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261624AbVDWQqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 12:46:19 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:49261 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261621AbVDWQqO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 12:46:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=fSflRvmOeEuoYLzUZcJWHw+YTCbhLViOGnV4S98srwHXZOMGLMgaX2c+4+EPQKbyoXp+y/WNVGiN3KvCEvkkR4yHagGKQYiwuBcwNBgK2AA5uwpG/1y0NEH2+Do8G25pvLPYUqLO9Y/VZu4hKzK9v1A6j1mSYd2gvkLm+uVqmC8=
Message-ID: <5a4c581d0504230946a20f3c8@mail.gmail.com>
Date: Sat, 23 Apr 2005 18:46:14 +0200
From: Alessandro Suardi <alessandro.suardi@gmail.com>
Reply-To: Alessandro Suardi <alessandro.suardi@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       cdwrite@other.debian.org
Subject: DVD burning problems on TS-H552 -> solved with firmware upgrade...
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A while ago I reported problems on lkml and cdwrite about
 burning DVDs with my Samsung TS-H552 drive:

http://lists.debian.org/cdwrite/2004/12/msg00088.html
 and
http://www.ussg.iu.edu/hypermail/linux/kernel/0501.2/2162.html

After resorting to installing Windows XP and seeing that
 I was able to successfully burn 2 DVDs with Pinnacle
 Instant CD-DVD - even reading video data from my ext3
 partitions via ext2fsd (http://ext2fsd.sourceforge.net),
 I decided to see whether any firmware updates for my
 drive were available.

I'm pleased to say that after flashing the TS08 firmware
 update (from TS03), I burned a dozen DVDs, video and
 data, Memorex +R and +RW and Verbatim +Rs with a
 100% success rate and 100% md5sum correctness.
The resulting discs play perfectly in my Sony LS755P
 standalone player.

Burning CDR and CDRW still works fine as ever. This is
 my same FC3 box, K7-800/256MB RAM, bittorrenting
 away during burns under a 2.6.12-rc2 kernel.


Thanks everyone for the support and patience :)

--alessandro

 "Fear is a dangerous thing
  It'll turn your heart black - you can trust"

    (Bruce Springsteen, "Devils And Dust")
