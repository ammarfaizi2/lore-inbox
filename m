Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288377AbSBDEbh>; Sun, 3 Feb 2002 23:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288354AbSBDEb1>; Sun, 3 Feb 2002 23:31:27 -0500
Received: from squeaker.ratbox.org ([63.216.218.7]:64260 "EHLO
	squeaker.ratbox.org") by vger.kernel.org with ESMTP
	id <S288377AbSBDEbY>; Sun, 3 Feb 2002 23:31:24 -0500
Date: Sun, 3 Feb 2002 23:38:19 -0500 (EST)
From: Aaron Sethman <androsyn@ratbox.org>
To: Dan Kegel <dank@kegel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Coder-Com] Re: PROBLEM: high system usage / poor SMPnetwork 
 performance
In-Reply-To: <3C5DE630.508DE9DB@kegel.com>
Message-ID: <Pine.LNX.4.44.0202032337251.3086-100000@simon.ratbox.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 3 Feb 2002, Dan Kegel wrote:
>
> But do you remember that this fd is ready until EWOULDBLOCK?
> i.e. if you're notified that an fd is ready, and then you
> don't for whatever reason continue to do I/O on it until EWOULDBLOCK,
> you'll never ever be notified that it's ready again.
> If your code assumes that it will be notified again anyway,
> as with poll(), it will be sorely disappointed.

Yeah that was the problem and I figured out how to work around it in the
code.  If you are interested I can point out the code we have been working
with.

Regards,

Aaron

