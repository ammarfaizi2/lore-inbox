Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263353AbREXD0X>; Wed, 23 May 2001 23:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263354AbREXD0N>; Wed, 23 May 2001 23:26:13 -0400
Received: from juicer39.bigpond.com ([139.134.6.96]:3043 "EHLO
	mailin8.bigpond.com") by vger.kernel.org with ESMTP
	id <S263353AbREXD0C>; Wed, 23 May 2001 23:26:02 -0400
To: linux-kernel@vger.kernel.org, monkeyiq@users.sourceforge.net
Subject: Dying disk and filesystem choice.
From: monkeyiq <monkeyiq@users.sourceforge.net>
X-Home-Page: http://witme.sourceforge.net
Date: 24 May 2001 13:25:51 +1000
Message-ID: <m3bsoj2zsw.fsf@kloof.cr.au>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (GTK)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
  Could I please be CC'd replies.

  To keep it short and sweet, I have a 45Gb IBM drive that
is slowly dying by getting more bad sectors. I have already
returned my first one to get the current disk, so would like
to use the current one for a while before returning it for 
another disk that will prolly just start dying again.

I am using reiserfs at the moment, which doesn't really like 
to work on a dying drive. for example, doing a make fails to
work even though it is *creating* files on the disk, it fails
to do so because it hits new bad sectors and doesn't seem to
remap them. 

I am wondering what advise on filesystem choice the list as
and any other options I can use to get the kernel to remap
bad blocks.

Thanks.

-- 
---------------------------------------------------
It's the question, http://witme.sourceforge.net
If you think education is expensive, try ignorance.
		-- Derek Bok, president of Harvard

