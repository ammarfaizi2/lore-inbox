Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131439AbRATSd1>; Sat, 20 Jan 2001 13:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131489AbRATSdI>; Sat, 20 Jan 2001 13:33:08 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:14404 "EHLO
	amsmta01-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S131033AbRATSc5>; Sat, 20 Jan 2001 13:32:57 -0500
Date: Sat, 20 Jan 2001 20:39:52 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: Mike Castle <dalgoda@ix.netcom.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Documenting stat(2)
In-Reply-To: <20010118170023.A3694@thune.yy.com>
Message-ID: <Pine.LNX.4.21.0101202038240.30209-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jan 2001, Mike Castle wrote:

> On Thu, Jan 18, 2001 at 09:52:02PM +0100, Igmar Palsenberg wrote:
> > I use lstat to check if a config file is a symlink, and if it is, it
> > refuses to open it. 
> 
> Nice race condition.

Agree, but still better then opening things that are actually a
symlink. Now would someone probably say : use the O_NOWFOLLOW option, but
since I do other checks that wouldn't be an option.

> mrc


	Igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
