Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319059AbSIJHPR>; Tue, 10 Sep 2002 03:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319060AbSIJHPR>; Tue, 10 Sep 2002 03:15:17 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:17047 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S319059AbSIJHPR>; Tue, 10 Sep 2002 03:15:17 -0400
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: Calculating kernel logical address ..
Date: 10 Sep 2002 07:03:44 GMT
Organization: SuSE Labs, =?ISO-8859-1?Q?Au=DFenstelle?= Berlin
Message-ID: <slrnanr6ag.4j2.kraxel@bytesex.org>
References: <019f01c25826$c553f310$9e10a8c0@IMRANPC> <Pine.LNX.3.95.1020909134937.18141A-100000@chaos.analogic.com> <20020909181355.GA1510567@sgi.com> <3D7CEB7F.8A8AFB26@digeo.com>
NNTP-Posting-Host: localhost
X-Trace: bytesex.org 1031641424 4707 127.0.0.1 (10 Sep 2002 07:03:44 GMT)
User-Agent: slrn/0.9.7.4 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > It looks drivers/media/video/video-buf.c uses alloc_kiovec() and
> > map_user_kiobuf() to do it.
>  
>  For video-buf.c and for Imran's application, that's just a wrapper
>  which is used to get at get_user_pages().

My latest video-buf.c version already uses get_user_pages() directly.
Get the latest bttv bits from http://bytesex.org/snapshot/ if you want
to have a look at the code.  Will go into 2.5 with the next batch of
video4linux updates.

  Gerd

-- 
You can't please everybody.  And usually if you _try_ to please
everybody, the end result is one big mess.
				-- Linus Torvalds, 2002-04-20
