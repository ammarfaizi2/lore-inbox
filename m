Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277159AbRJDSQI>; Thu, 4 Oct 2001 14:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277182AbRJDSP5>; Thu, 4 Oct 2001 14:15:57 -0400
Received: from Aniela.EU.ORG ([194.102.102.235]:1028 "EHLO NS1.Aniela.EU.ORG")
	by vger.kernel.org with ESMTP id <S277159AbRJDSPl>;
	Thu, 4 Oct 2001 14:15:41 -0400
Date: Thu, 4 Oct 2001 21:16:04 +0300 (EEST)
From: <lk@Aniela.EU.ORG>
To: Karl Pitrich <pit@root.at>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: 100% sync block device on 2.2 ?
In-Reply-To: <Pine.LNX.4.33.0110041629170.1056-100000@warp.root.at>
Message-ID: <Pine.LNX.4.33.0110042115300.398-100000@ns1.Aniela.EU.ORG>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1 5000 5 25 1 100 100 1 1
>
> so, it should flush dirty buffers all 100hz, if i am right.
>
> is there any way to bypass/disable buffer cache for my block device?
> why does this work in floppy.c?
> how does sct's rawdevice stuff do this?
> (i checked both .c but cant get the clue)
>

while :; do sync ; done


and everything should be in sync :)


> thanks a lot for help, karl.
>
>

