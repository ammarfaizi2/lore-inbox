Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286123AbRLVAwH>; Fri, 21 Dec 2001 19:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286303AbRLVAv5>; Fri, 21 Dec 2001 19:51:57 -0500
Received: from norma.kjist.ac.kr ([203.237.41.18]:23681 "EHLO
	norma.kjist.ac.kr") by vger.kernel.org with ESMTP
	id <S286123AbRLVAvs>; Fri, 21 Dec 2001 19:51:48 -0500
Message-ID: <3C23D919.9080606@nospam.com>
Date: Sat, 22 Dec 2001 09:51:37 +0900
From: Hugh <hugh@nospam.com>
User-Agent: Mozilla/5.0 (X11; U; Linux alpha; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: ko, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Reiserfs error in 2.4.17-rc1 and rc2
Content-Type: multipart/mixed;
 boundary="------------090205020504050607080501"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090205020504050607080501
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit

I am the one who started this this thread.
I am very sorry.  I found that the machine I had the reiserfs error
was running on the 2.4.17-pre6, not one of those rc1 or rc2.

Beside that, I still have a concern on the security level of the
reiserfs in general.  On the linux-kernel list, I see more articles
on the troubles of reiserfs than on the troubles of ext3.

Is ext3 more stabilized by now or is ext3 less used in the linux
community?


Again, my apology for the misinformation in the original article.

Best regards,

Hugh

--------------090205020504050607080501
Content-Type: message/rfc822;
 name="Reiserfs error in 2.4.17-rc1 and rc2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Reiserfs error in 2.4.17-rc1 and rc2"

X-Mozilla-Status2: 00000000
Message-ID: <3C22A2B5.3010205@nospam.com>
Date: Fri, 21 Dec 2001 11:47:17 +0900
From: Hugh <hugh@nospam.com>
User-Agent: Mozilla/5.0 (X11; U; Linux alpha; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: ko, en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Reiserfs error in 2.4.17-rc1 and rc2
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit

My linux partitions are all Reiserfs format right now.
I moved from 2.4.17-pre1 to 2.4.17-rc2.  On such
During the backup at night, I got a strange error saying
in the line of

".... journaling ... write/buffer ..."

in a plain user's console.


I immediately realized that it is reiserfs related.

There are a lot of reiserfs users, especially in the SuSE
camp.  If the kernel has a serious bug related to Reiserfs,
that kernel should be marked as "Don't use".

I went back to 2.4.17-pre1 and trying to do "reiserfsck"
on all my partitions.
BTW, "reiserfsck" on a 36GB SCSI driver takes almost forever.
Is it normal?

I am seriously concerned with the integrity of my data.
Should I switch back to ext2 for my data partition?

Thanks for the information in advance

Best regards,

G. Hugh Song



--------------090205020504050607080501--

