Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262076AbRE3Ue0>; Wed, 30 May 2001 16:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262094AbRE3UeQ>; Wed, 30 May 2001 16:34:16 -0400
Received: from www.wen-online.de ([212.223.88.39]:43017 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S262076AbRE3UeG>;
	Wed, 30 May 2001 16:34:06 -0400
Date: Wed, 30 May 2001 22:33:09 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Rik van Riel <riel@conectiva.com.br>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Jonathan Morton <chromi@cyberspace.org>,
        Craig Kulesa <ckulesa@as.arizona.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: Plain 2.4.5 VM
In-Reply-To: <Pine.LNX.4.21.0105301537150.12540-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.33.0105302225010.418-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 May 2001, Rik van Riel wrote:

> On Wed, 30 May 2001, Marcelo Tosatti wrote:
>
> > The problem is that we allow _every_ task to age pages on the system
> > at the same time --- this is one of the things which is fucking up.
>
> This should not have any effect on the ratio of cache
> reclaiming vs. swapout use, though...

It shouldn't.. but when many tasks are aging, it does.  Excluding
these guys certainly seems to make a difference.  (could be seeing
something else and interpreting it wrong...)

	-Mike

