Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269416AbUINPxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269416AbUINPxE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 11:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269437AbUINPnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 11:43:31 -0400
Received: from post.pl ([212.85.96.51]:43020 "HELO v00051.home.net.pl")
	by vger.kernel.org with SMTP id S269415AbUINPkj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 11:40:39 -0400
Message-ID: <41471179.5090003@post.pl>
Date: Tue, 14 Sep 2004 17:42:49 +0200
From: Marcin Garski <mgarski@post.pl>
Reply-To: mgarski@post.pl
User-Agent: Mozilla Thunderbird 0.7.2 (Linux)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Copying huge amount of data on ReiserFS, XFS and Silicon Image
 3112 cause oops.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Please CC me on replies, I am not subscribed to the list, thanks]

Nathan Scott wrote:
 >>>>I bought a new HDD Maxtor 6Y160M0 and connected it as hdg to Sil 3112
 >>>>(CONFIG_BLK_DEV_SIIMAGE) on Abit NF7-S V2.0. I also have ST380013AS
 >>>>(with Fedora Core 2 on hde2 and 2.6.5 kernel) as hde.
 >
 >>
 >>
 >> Possible hardware problems?  Have you run memtest there?

I forgot to mention about that in previous email.
Yes i've run memtest+ and nothing wrong was detected.

 >> Was 4KSTACKS enabled in those kernels (I think so)? - XFS
 >> has one known problem with that option when running low on
 >> space (patch fixing that is being tested atm) and I think
 >> the reiserfs folks had some 4k stack issues as well at one
 >> point, so that might be another explanation.

No, 4KSTACKS was disabled, because both kernels was compiled by myself
and i always disable 4KSTACKS.

-- 
Best Regards
Marcin Garski
