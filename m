Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313167AbSEEQju>; Sun, 5 May 2002 12:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313183AbSEEQjt>; Sun, 5 May 2002 12:39:49 -0400
Received: from relay1.pair.com ([209.68.1.20]:37900 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S313167AbSEEQjs>;
	Sun, 5 May 2002 12:39:48 -0400
X-pair-Authenticated: 24.126.75.99
Message-ID: <3CD560FB.C6736001@kegel.com>
Date: Sun, 05 May 2002 09:42:35 -0700
From: Dan Kegel <dank@kegel.com>
Reply-To: dank@kegel.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:
> As Keith says, the new code is faster and more robust than the old
> code. Given that tracking kernel drift is a significant load on him,
> it makes sense to incorporate the new code now. Once it's in, let
> people get used to it and then we can look at optimising it, if need
> be. Delaying introduction into the kernel tree because it's not 100%
> optimised is wasteful.

Keith also says:
> I am temporarily omitting [modversions] which is (a) currently broken
> (b) is not being used in development kernels and (c) cannot be fixed
> without a radical redesign.  Modversions is not needed right now and
> will be added later.  Everything I have done in kbuild 2.5 is needed
> now

[Caveat: I'm not much of a kernel hacker.]
My only concern with kbuild 2.5 was the lack of modversions,
but since Richard is promising to add them in before the
distros need them, I would have no qualms about kbuild 2.5
totally replacing the old build system for the next 2.5 kernel.
I'm sick and tired of 'make dep'.

What does Alan Cox think?
- Dan
