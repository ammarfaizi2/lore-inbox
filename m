Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286871AbSBDSwc>; Mon, 4 Feb 2002 13:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286893AbSBDSwW>; Mon, 4 Feb 2002 13:52:22 -0500
Received: from squeaker.ratbox.org ([63.216.218.7]:35335 "EHLO
	squeaker.ratbox.org") by vger.kernel.org with ESMTP
	id <S286871AbSBDSwK>; Mon, 4 Feb 2002 13:52:10 -0500
Date: Mon, 4 Feb 2002 13:59:09 -0500 (EST)
From: Aaron Sethman <androsyn@ratbox.org>
To: Kev <klmitch@MIT.EDU>
Cc: Darren Smith <data@barrysworld.com>, "'Andrew Morton'" <akpm@zip.com.au>,
        "'Dan Kegel'" <dank@kegel.com>,
        "'Vincent Sweeney'" <v.sweeney@barrysworld.com>,
        <linux-kernel@vger.kernel.org>, <coder-com@undernet.org>
Subject: Re: [Coder-Com] Re: PROBLEM: high system usage / poor SMP network
 performance
In-Reply-To: <200202041848.NAA04094@coleco-sidewinder.mit.edu>
Message-ID: <Pine.LNX.4.44.0202041358180.4584-100000@simon.ratbox.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Feb 2002, Kev wrote:
> Wouldn't have the effect.  The original point was that adding the usleep()
> gives some time for some more file descriptors to become ready before calling
> poll(), thus increasing the number of file descriptors poll() can return
> per system call.  Adding the time to timeout would have no effect.

My fault, I'm not thinking straight today.  I don't believe I've had my
daily allowance of caffine yet.

Regards,

Aaron

