Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284334AbRLBUhg>; Sun, 2 Dec 2001 15:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284331AbRLBUhY>; Sun, 2 Dec 2001 15:37:24 -0500
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:37248 "EHLO
	Elf.ucw.cz") by vger.kernel.org with ESMTP id <S284320AbRLBUfr>;
	Sun, 2 Dec 2001 15:35:47 -0500
Date: Wed, 28 Nov 2001 00:47:58 +0000
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@zip.com.au>
Cc: Kamil Iskra <kamil@science.uva.nl>, linux-kernel@vger.kernel.org
Subject: Re: Problems with APM suspend and ext3
Message-ID: <20011128004758.C37@toy.ucw.cz>
In-Reply-To: <Pine.LNX.4.33.0111270958320.3391-100000@krakow.science.uva.nl> <3C03CEFB.780622F1@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3C03CEFB.780622F1@zip.com.au>; from akpm@zip.com.au on Tue, Nov 27, 2001 at 09:35:55AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> thank you for the clear and convincing problem description.
> 
> It's becoming increasingly clear that we need to do something with
> ext3 and laptops.
> 
> I don't understand what can be causing the behaviour which you
> report.  Presumably, some application is generating disk writes,
> and kjournald is thus performing disk IO every five seconds.
> But I don't know why this should prevent the machine from suspending,
> nor why it's different with other filesystems.

Disk writes should not prevent suspend... unless he has buggy apm bios.
But I can not imagine bug doing _that_...

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

