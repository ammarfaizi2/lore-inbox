Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315618AbSEIF3B>; Thu, 9 May 2002 01:29:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315619AbSEIF3B>; Thu, 9 May 2002 01:29:01 -0400
Received: from zok.SGI.COM ([204.94.215.101]:4542 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S315618AbSEIF27>;
	Thu, 9 May 2002 01:28:59 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "P a v a n" <pavankvk@indiatimes.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cdp Strange behavior? 
In-Reply-To: Your message of "Thu, 09 May 2002 09:55:28 +0530."
             <200205090428.JAA05676@WS0005.indiatimes.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 09 May 2002 15:27:43 +1000
Message-ID: <16774.1020922063@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 May 2002 09:55:28 +0530, 
"P a v a n" <pavankvk@indiatimes.com> wrote:
>yesterday i got my redhat 7.2 up and running.it had a package for palying audiocd's.its called cdp and had a text interface for a dumb terminal.inoticed a strange behavior.i was listening to the song and i gave the shutdown command..even when the system i completely halted(power down too) the cdp is still running.(i think it should as iam listening  the songs still).i have a creative cdrom.i have a doubt.are there any cdroms which are programmed to behave this way.i mean which depend on BIOS may be..i didnt make anything how its running.

Please learn to use word wrap, long lines are difficult to read.

This is normal processing.  cdp just tells the cdrom to play, it is
then outside kernel control.  You can get the same effect by starting
cdp then killing it, the cd continues to play.

