Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261820AbTCQRtN>; Mon, 17 Mar 2003 12:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261821AbTCQRtN>; Mon, 17 Mar 2003 12:49:13 -0500
Received: from news.cistron.nl ([62.216.30.38]:16394 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id <S261820AbTCQRtM>;
	Mon, 17 Mar 2003 12:49:12 -0500
From: miquels@cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: select() stress
Date: Mon, 17 Mar 2003 18:00:06 +0000 (UTC)
Organization: Cistron Group
Message-ID: <b552f6$eao$2@news.cistron.nl>
References: <Pine.WNT.4.44.0303171010580.1544-100000@GOLDENEAGLE.gameday2000> <Pine.LNX.4.53.0303171112090.22652@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1047924006 14680 62.216.29.200 (17 Mar 2003 18:00:06 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.53.0303171112090.22652@chaos>,
Richard B. Johnson <root@chaos.analogic.com> wrote:
>select() takes a file-descriptor as its first argument, not the
>return-value of some function that returns the number of file-
>descriptors. You cannot assume that this number is the same
>as the currently open socket. Just use the socket-value. That's
>the file-descriptor.

Duh? "man select".

Mike.
-- 
Anyone who is capable of getting themselves made President should
on no account be allowed to do the job -- Douglas Adams.

