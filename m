Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314303AbSEFJtK>; Mon, 6 May 2002 05:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314318AbSEFJtJ>; Mon, 6 May 2002 05:49:09 -0400
Received: from [195.39.17.254] ([195.39.17.254]:21652 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S314303AbSEFJtI>;
	Mon, 6 May 2002 05:49:08 -0400
Date: Sat, 27 Apr 2002 02:56:42 +0000
From: Pavel Machek <pavel@suse.cz>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Dave Jones <davej@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.12] x86 Boot enhancements, boot params 1/11
Message-ID: <20020427025642.E413@toy.ucw.cz>
In-Reply-To: <m11ycuzk4q.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> #5  boot.heap
> ============================================================
> Modify video.S so that mode_list is also allocated from
> the boot time heap.  This probably saves a little memory,
> and makes a compiled in command line a sane thing to implement.

Do you see easy way to pass video mode used to kernel? S3 suspend support
is going to need that..
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

