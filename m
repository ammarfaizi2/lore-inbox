Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135915AbREFX1A>; Sun, 6 May 2001 19:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135917AbREFX0v>; Sun, 6 May 2001 19:26:51 -0400
Received: from adsl-204-0-249-112.corp.se.verio.net ([204.0.249.112]:21755
	"EHLO tabby.cats-chateau.net") by vger.kernel.org with ESMTP
	id <S135915AbREFX0f>; Sun, 6 May 2001 19:26:35 -0400
From: Jesse Pollard <jesse@cats-chateau.net>
Reply-To: jesse@cats-chateau.net
To: Rick Hohensee <humbubba@smarty.smart.net>, linux-kernel@vger.kernel.org
Subject: Re: inserting a Forth-like language into the Linux kernel
Date: Sun, 6 May 2001 18:24:45 -0500
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <200105060357.XAA29873@smarty.smart.net>
In-Reply-To: <200105060357.XAA29873@smarty.smart.net>
MIME-Version: 1.0
Message-Id: <01050618263300.10132@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 05 May 2001, Rick Hohensee wrote:
>kspamd/H3sm is now making continuous writes to tty1 from an 
>in-kernel thread. It was locking on a write to /dev/console by
>init, so I made /dev/console a plain file. This is after 
>hollowing out sys_syslog to be a null routine, and various 
>other minor destruction.
>
>I am now typing at you on tty4 or so while the kernel itself 
>sends an endless stream of d's to tty1. It will scroll-lock 
>and un-scroll-lock, which is how I can tell it's not just a 
>static screen of d's.
>
>I don't know about H1 S&M, but the ability to open a tty
>normally directly into kernelspace may prove popular, particularly 
>with a Forth on that tty in that kernelspace. Persons with actual 
>kernel clue may want to look at allowing /dev/console users and 
>an in-kernel tty user to play nice. For my purposes I'll do without 
>a real /dev/console and syslogging for now. 
>
>Now I get to find out how many worlds of trouble I didn't foresee
>in _reading_ a tty from the kernel :o)
>
>If someone knows of another example of interpreter-like behavior 
>directly in a unix in-kernel thread I'd like to know about it.  

Only in reference to allowing for virus infection of the kernel.

It isn't a good idea.

-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: jesse@cats-chateau.net

Any opinions expressed are solely my own.
