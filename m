Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278381AbRJMTeK>; Sat, 13 Oct 2001 15:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278380AbRJMTdx>; Sat, 13 Oct 2001 15:33:53 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:13060 "EHLO
	bug.ucw.cz") by vger.kernel.org with ESMTP id <S278379AbRJMTc4>;
	Sat, 13 Oct 2001 15:32:56 -0400
Date: Fri, 12 Oct 2001 13:22:20 +0000
From: Pavel Machek <pavel@suse.cz>
To: Robert Love <rml@ufl.edu>
Cc: Andrea Arcangeli <andrea@suse.de>, safemode <safemode@speakeasy.net>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.10-ac10-preempt lmbench output.
Message-ID: <20011012132220.B35@toy.ucw.cz>
In-Reply-To: <20011010003636Z271005-760+23005@vger.kernel.org> <20011010031803.F8384@athlon.random> <20011010020935.50DEF1E756@Cantor.suse.de> <20011010043003.C726@athlon.random> <1002681480.1044.67.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <1002681480.1044.67.camel@phantasy>; from rml@ufl.edu on Tue, Oct 09, 2001 at 10:37:56PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Now dbench (or any task) is in kernel space for too long.  The CPU time
> xmms needs will of course still be given, but _too late_.  Its just not
> a cpu resource problem, its a timing problem.  xmms needs x units of CPU
> every y units of time.  Just getting the x whenever is not enough.

Yep, with

x = 60msec
y = 600msec

So you can give it time up to 540msec late with no drop-outs.

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

