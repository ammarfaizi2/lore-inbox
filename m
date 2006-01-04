Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965228AbWADHmQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965228AbWADHmQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 02:42:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751589AbWADHmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 02:42:16 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:55307 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S1751201AbWADHmQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 02:42:16 -0500
Date: Wed, 04 Jan 2006 01:43:01 -0600 (CST)
Message-Id: <20060104.014301.113325512.yoshfuji@linux-ipv6.org>
To: dmlb2000@gmail.com
Cc: yoshfuji@linux-ipv6.org, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rt1
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <9c21eeae0601032316l3259fbecle6a0b290ed244e12@mail.gmail.com>
References: <9c21eeae0601031512m44c4a269ua2214528eaf90914@mail.gmail.com>
	<20060103.202422.50699198.yoshfuji@linux-ipv6.org>
	<9c21eeae0601032316l3259fbecle6a0b290ed244e12@mail.gmail.com>
Organization: USAGI/WIDE Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <9c21eeae0601032316l3259fbecle6a0b290ed244e12@mail.gmail.com> (at Tue, 3 Jan 2006 23:16:02 -0800), David Brown <dmlb2000@gmail.com> says:

> patch-2.6.15-rt1-1 has the ipv6 patch yet is smaller than the initial
> patch. I created the patch using:
> $ diff -uprN linux-2.6.15 linux-2.6.15-rt1 > patch-2.6.15-rt1-1
> 
> Is this not the way you did it? I noticed different headers in my
> patch vs. the patch posted. Really I'm concerned about missing
> anything in the patch, considering it's 700+ lines smaller.

I have linux-2.6 git tree and I did something like this:

$ cd linux-2.6
$ patch -p1 < /tmp/patch-2.6.15-rt1
hack, hack, hack...
$ patch -p1 -R < /tmp/patch-2.6.15-rt1
$ git reset
$ git diff

--yoshfuji
