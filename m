Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131424AbRCWU2B>; Fri, 23 Mar 2001 15:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131419AbRCWU1w>; Fri, 23 Mar 2001 15:27:52 -0500
Received: from dentin.eaze.net ([216.228.128.151]:30212 "EHLO xirr.com")
	by vger.kernel.org with ESMTP id <S131446AbRCWU1m>;
	Fri, 23 Mar 2001 15:27:42 -0500
Date: Fri, 23 Mar 2001 14:25:56 -0600 (CST)
From: SodaPop <soda@xirr.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Rik van Riel <riel@conectiva.com.br>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <3ABB992F.D898885C@evision-ventures.com>
Message-ID: <Pine.LNX.4.30.0103231423310.27259-100000@xirr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Mar 2001, Martin Dalecki wrote:

> SodaPop wrote:
> >
> > Rik, is there any way we could get a /proc entry for this, so that one
> > could do something like:
>
> I will respond; NO there is no way for security reasons this is not a
> good idea.
>
> > cat /proc/oom-kill-scores | sort +3

Oh, you mean like /proc/kcore is a bad idea for security reasons?

Duh, make its permission bits 400.

-dennis T


