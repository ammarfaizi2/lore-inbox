Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269151AbTB0C0A>; Wed, 26 Feb 2003 21:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269152AbTB0C0A>; Wed, 26 Feb 2003 21:26:00 -0500
Received: from nwkea-mail-1.sun.com ([192.18.42.13]:49643 "EHLO
	nwkea-mail-1.sun.com") by vger.kernel.org with ESMTP
	id <S269151AbTB0CZ7>; Wed, 26 Feb 2003 21:25:59 -0500
Message-ID: <3E5D799B.7030207@sun.com>
Date: Wed, 26 Feb 2003 18:36:11 -0800
From: Tim Hockin <thockin@sun.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Quota and Q_SYNC - broken
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can someone please fill me in on two questions?

1)  Why did the Q_SYNC and friends constants get changed?  I have old 
binaries that don't work anymore, and in fact, new binaries don't work 
either unless I update my sys/quota.h.

2)  Does quoatctl(Q_SYNC) still work with a NULL special (meaning sync 
all quotas)?  The man page has it listed, but it seems to be broken.

I'll provide a patch for the second, if someone wants to point out why 
the first was broken (braindead) and what the preferred solution is.

Thanks.

Tim
-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Linux Kernel Engineering
thockin@sun.com

