Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261172AbREORhM>; Tue, 15 May 2001 13:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261184AbREORhC>; Tue, 15 May 2001 13:37:02 -0400
Received: from www.wen-online.de ([212.223.88.39]:18949 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S261172AbREORgz>;
	Tue, 15 May 2001 13:36:55 -0400
Date: Tue, 15 May 2001 19:36:39 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Jeff Golds <jgolds@resilience.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove silly beep macro from pgtable.h
In-Reply-To: <3B015D19.E5581AAD@resilience.com>
Message-ID: <Pine.LNX.4.33.0105151911410.730-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 May 2001, Jeff Golds wrote:

> Hi folks,
>
> Found this bit of unused code in the i386 and sh architectures.  As it's not being used, let's get rid of it.  Also, pgtable.h seems to be an odd place for this.

I'd leave it.. folks with early boot troubles might find it useful.

	-Mike

