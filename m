Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261258AbSJLPPZ>; Sat, 12 Oct 2002 11:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261263AbSJLPPZ>; Sat, 12 Oct 2002 11:15:25 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:60939 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S261258AbSJLPPZ>; Sat, 12 Oct 2002 11:15:25 -0400
Date: Sat, 12 Oct 2002 16:21:07 +0100
From: John Levon <levon@movementarian.org>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] tasks.h
Message-ID: <20021012152107.GA55167@compsoc.man.ac.uk>
References: <Pine.LNX.4.33.0210120842070.25918-100000@gans.physik3.uni-rostock.de> <200210121703.11220.arnd@bergmann-dalldorf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210121703.11220.arnd@bergmann-dalldorf.de>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan *180O4h-000Ejx-00*qeIXrAqYcOQ* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 12, 2002 at 05:03:11PM +0200, Arnd Bergmann wrote:

> AFAICS, get_task_mm() is never used in a fast path, only in
> ptrace and procfs code where a few cpu cycles don't hurt anyone.

You're right. Just need to find a sensible file to put it in. I don't
think there's any module users so you shouldn't need to export it
either.

regards
john

-- 
"That's just kitten-eating wrong."
	- Richard Henderson
