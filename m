Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130301AbRBZOei>; Mon, 26 Feb 2001 09:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130239AbRBZObs>; Mon, 26 Feb 2001 09:31:48 -0500
Received: from zeus.kernel.org ([209.10.41.242]:53191 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130294AbRBZO35>;
	Mon, 26 Feb 2001 09:29:57 -0500
Date: Mon, 26 Feb 2001 11:26:00 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Marc Lehmann <pcg@goof.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: linux swap freeze STILL in 2.4.x
In-Reply-To: <20010226094000.A4228@fuji.laendle>
Message-ID: <Pine.LNX.4.33.0102261110001.1917-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Feb 2001, Marc Lehmann wrote:

> On Mon, Feb 26, 2001 at 08:11:55AM +0100, Mike Galbraith <mikeg@wen-online.de> wrote:
>
> > Anyway, it works fine here with virgin 2.4.2, so it seems unlikely it's
> > a kernel problem.
>
> > 259   execve("/sbin/losetup", ["losetup", "/dev/loop0", "/dev/hda5"], [/* 47 vars */]) = 0
>
> The -e switch is causing the memory fault and subsequent breakage:

No problem here using -e xor. (have no real crypto to try)

> However, I just need to wait until there is a new crypto patch (and, if
> not, I'll eventually have to hack it myself to gte my data. After all it's
> source... ...)

Probably.

	-Mike

