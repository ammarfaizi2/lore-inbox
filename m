Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135284AbRDVU5K>; Sun, 22 Apr 2001 16:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135288AbRDVU5B>; Sun, 22 Apr 2001 16:57:01 -0400
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:33925 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S135284AbRDVU4w>;
	Sun, 22 Apr 2001 16:56:52 -0400
Message-ID: <3AE34586.B4284FDD@mirai.cx>
Date: Sun, 22 Apr 2001 13:56:38 -0700
From: J Sloan <jjs@mirai.cx>
Organization: Mirai Consulting
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@redhat.com>
Subject: Re: performance degradation on -ac tree
In-Reply-To: <E14pqgA-0004Yt-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a bit more clarity on the performance degradation
issue now - In fact the degradation only appears when
using iptables. It's just that sometime shortly after 2.4.2,
the hit imposed by iptables got worse.

For instance:

netperf results  without iptables       with iptables
-----------------------------------------------------------------
2.4.2                 400 MB/s                      330 MB/s
2.4.3-ac10            400 MB/s                      250 MB/s


BTW, the stock seawolf kernel gets the highest netperf
results ever seen on this box, around 450 MB/sec,
but with iptables or ipchains module loaded, it falls to
about 270 MB/sec.

Just a data point fyi -

cu

jjs



