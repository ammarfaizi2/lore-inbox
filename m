Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289621AbSBSECF>; Mon, 18 Feb 2002 23:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289627AbSBSEBz>; Mon, 18 Feb 2002 23:01:55 -0500
Received: from adsl-209-76-109-63.dsl.snfc21.pacbell.net ([209.76.109.63]:1920
	"EHLO adsl-209-76-109-63.dsl.snfc21.pacbell.net") by vger.kernel.org
	with ESMTP id <S289621AbSBSEBe>; Mon, 18 Feb 2002 23:01:34 -0500
Date: Mon, 18 Feb 2002 20:00:51 -0800
From: Wayne Whitney <whitney@math.berkeley.edu>
Message-Id: <200202190400.g1J40pT09772@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
To: Gustavo Noronha Silva <kov@debian.org>,
        Alessandro Suardi <alessandro.suardi@oracle.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: gnome-terminal acts funny in recent 2.5 series
In-Reply-To: <20020218213917.60e4dd5c.kov@debian.org>
In-Reply-To: <3C719641.3040604@oracle.com> <3C719641.3040604@oracle.com> <20020218213917.60e4dd5c.kov@debian.org>
Reply-To: whitney@math.berkeley.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In mailing-lists.linux-kernel, Gustavo wrote:

> I noticed this problem also... it seems the problem lies on
> devpts, I enabled it on my 2.5.5pre1 build, mounting
> devpts with the options given on the "readme" file
> made gnome-terminal start on the second try, almost
> everytime

I also am seeing this problem--it is definitely pts related.  I have
noticed that when the problem occurs, if I execute "gnome-terminal &"
from an existing gnome-terminal, a new window comes up, but input and
output from the new shell are still going to the prior gnome-terminal.
'ps' shows both the new gnome-terminal and old gnome-terminal on the
same pts.  But sometimes everything works fine.

Cheers, Wayne

