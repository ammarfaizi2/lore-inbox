Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271379AbTHRKzF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 06:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271388AbTHRKzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 06:55:04 -0400
Received: from smtp1.att.ne.jp ([165.76.15.137]:60315 "EHLO smtp1.att.ne.jp")
	by vger.kernel.org with ESMTP id S271381AbTHRKzB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 06:55:01 -0400
Message-ID: <151801c36577$10e4f5a0$1aee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Greg KH" <greg@kroah.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andries Brouwer" <aebr@win.tue.nl>, "Vojtech Pavlik" <vojtech@suse.cz>
References: <138e01c364ab$15b6c2b0$1aee4ca5@DIAMONDLX60> <1061141113.21878.76.camel@dhcp23.swansea.linux.org.uk>
Subject: Re: Trying to run 2.6.0-test3
Date: Mon, 18 Aug 2003 19:35:09 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Alan Cox" <alan@lxorguk.ukuu.org.uk> replied to me.

> > accept a USB keyboard but they refused.  The patch which I sent to Vojtech
> > Pavlik was ignored and these two keys continued not to work (except on my
> > machine).  Finally Mike Fabian accepted a gift of a USB keyboard and this
> > defect in Linux got fixed.  But only for somewhere around the last half of
> > the 2.4 releases, not for 2.6.
> > What will it take this time?
>
> Posting the patch with any luck ?

Hirofumi Ogawa posted a patch for the yen-sign pipe key on 2003.07.23 for
test1 but his patch still didn't get into test3.  On a PS/2 keyboard that
seems to be the only key with any problem.

Yesterday when I finally tried a USB keyboard and found that the backslash
underbar has the same problem, maybe I was the first person to even try a
Japanese USB keyboard in 2.6, and maybe no one at all tried some number of
2.5 series kernels.  As mentioned, usually I can only spend one day a week
testing 2.6.  I'll try to spend one day next weekend trying to figure out
the new necessary patch.  If I succeed, but if it gets ignored again, I'll
probably rejoin the set of users who never have time to test.

I really do think that if Andries Brouwer or Vojtech Pavlik would accept a
gift of a USB keyboard then this kind of bug would be avoided a lot earlier.

