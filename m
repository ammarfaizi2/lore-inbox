Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263703AbRFSFb4>; Tue, 19 Jun 2001 01:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263746AbRFSFbp>; Tue, 19 Jun 2001 01:31:45 -0400
Received: from www.wen-online.de ([212.223.88.39]:39432 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S263703AbRFSFbj>;
	Tue, 19 Jun 2001 01:31:39 -0400
Date: Tue, 19 Jun 2001 07:30:42 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: root <root@norma.kjist.ac.kr>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 VM & swap question
In-Reply-To: <200106181121.f5IBLdc02300@norma.kjist.ac.kr>
Message-ID: <Pine.LNX.4.33.0106190725040.576-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jun 2001, root wrote:

> Regarding to the discussion on the swap size,
>
> Recently, Rick van Riel posted a message that there is a bug
> related to "reclaiming" the swap, and said that it is on his
> TODO list.

That's fixed.

> If I believe it, the current trouble we have regarding to the swap
> size is not because we do not have a sufficient size for the swap,
> but because there is a bug, although Linus advised us to assign
> 2 times the physical memory for the swap.

Please try 2.4.6.pre3.  (folks with various load types should do this
and report results.. even if it generates a brief spurt of traffic).

	-Mike

