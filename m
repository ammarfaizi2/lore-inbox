Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267372AbSLLAFx>; Wed, 11 Dec 2002 19:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267371AbSLLAFw>; Wed, 11 Dec 2002 19:05:52 -0500
Received: from packet.digeo.com ([12.110.80.53]:26088 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267364AbSLLAFu>;
	Wed, 11 Dec 2002 19:05:50 -0500
Message-ID: <3DF7D4A9.C93316D8@digeo.com>
Date: Wed, 11 Dec 2002 16:13:29 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Steven Roussey <sroussey@network54.com>
CC: robm@fastmail.fm, linux-kernel@vger.kernel.org
Subject: Re: Strange load spikes on 2.4.19 kernel
References: <3DF7C5B2.D9E0249C@digeo.com> <001d01c2a170$b72639e0$026fa8c0@wehohome>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Dec 2002 00:13:29.0970 (UTC) FILETIME=[4CAFDD20:01C2A173]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Roussey wrote:
>
> 500      32429  0.3  1.1 41948 9148 ?        R    15:19   0:06 /usr/local/apache/bin/httpd -DSSL

Looks like all your apache instances woke up and started doing something.
What makes you think it's a kernel or ext3 thing?

If there were processes there in `D' state then it would probably
be related to filesystem activity.  But that does not appear to
be the case.
