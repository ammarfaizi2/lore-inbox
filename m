Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282329AbRLOKU0>; Sat, 15 Dec 2001 05:20:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282413AbRLOKUQ>; Sat, 15 Dec 2001 05:20:16 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:24840 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S282329AbRLOKUF>;
	Sat, 15 Dec 2001 05:20:05 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200112151019.fBFAJgS235075@saturn.cs.uml.edu>
Subject: Re: [PATCH] kill(-1,sig)
To: torvalds@transmeta.com (Linus Torvalds)
Date: Sat, 15 Dec 2001 05:19:42 -0500 (EST)
Cc: sim@netnation.com (Simon Kirby), Andries.Brouwer@cwi.nl,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0112141237470.3063-100000@penguin.transmeta.com> from "Linus Torvalds" at Dec 14, 2001 12:40:16 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:
> On Fri, 14 Dec 2001, Simon Kirby wrote:

>> it kills everything _and_ itself.  I frequently use "kill -9 -1" to kill
>> everything except my shell, and now I'll have to kill everything else
>> manually, one by one.
>
> I do agree, I've used "kill -9 -1" myself.

This means: EVERYTHING DIE DIE DIE!!!!

On a Digital UNIX system, I do "/bin/kill -9 -1" often. I expect it to
kill the shell. This is a nice way to quickly log out and wipe out any
background processes that might try to save state or continue running.

So the standards violation isn't appreciated by all.
