Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316210AbSGLRrx>; Fri, 12 Jul 2002 13:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316503AbSGLRrw>; Fri, 12 Jul 2002 13:47:52 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:38923 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316210AbSGLRrt>; Fri, 12 Jul 2002 13:47:49 -0400
Date: Fri, 12 Jul 2002 10:52:20 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: "H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
Subject: Re: IDE/ATAPI in 2.5
In-Reply-To: <3D2EC778.7000203@evision-ventures.com>
Message-ID: <Pine.LNX.4.44.0207121050230.14359-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 12 Jul 2002, Martin Dalecki wrote:
>
> So Linus what's your opinnion please?

I will violently oppose anything that implies that the IDE layer uses the
SCSI layer normally.  No way, Jose. I'm all for scrapping, but the thing
that should be scrapped is ide-scsi.

The higher layers already have much of what the SCSI layer does, and the
SCSI layer itself is slowly moving in that direction.

		Linus

