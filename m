Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280822AbRKVUKy>; Thu, 22 Nov 2001 15:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281504AbRKVUKo>; Thu, 22 Nov 2001 15:10:44 -0500
Received: from www.wen-online.de ([212.223.88.39]:25097 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S280822AbRKVUKh>;
	Thu, 22 Nov 2001 15:10:37 -0500
Date: Thu, 22 Nov 2001 21:10:07 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: OOM killer in 2.4.15pre1 still not 100% ok
In-Reply-To: <01112217224700.01298@manta>
Message-ID: <Pine.LNX.4.33.0111222046330.562-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Nov 2001, vda wrote:

> Today I saw OOM killer in action for the very fist time.
> Just want to inform that it still not 100% ok (IMHO):

With no swap, seems pretty frisky in pre9.  I can't start X/KDE
with a 64MB ram boot.  Touching the end of ram is very deadly atm
with no swap enabled.. can't say it's a wrong behavior though, as
I am touching the end.  (I think I'd _rather_ it die than thrash)

	-Mike

