Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316897AbSE1UgK>; Tue, 28 May 2002 16:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316898AbSE1UgK>; Tue, 28 May 2002 16:36:10 -0400
Received: from [195.39.17.254] ([195.39.17.254]:55196 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S316897AbSE1UgJ>;
	Tue, 28 May 2002 16:36:09 -0400
Date: Mon, 27 May 2002 13:59:17 +0000
From: Pavel Machek <pavel@suse.cz>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19-pre8-ac5 swsusp panic
Message-ID: <20020527135916.F35@toy.ucw.cz>
In-Reply-To: <20020524011322.GA6612@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I tried SysRq-D and finally got a kernel "panic: Request while ide driver
> is blocked?"

sysrq-D showed to be buggy in 2.5. You might want to do echo 4 > 
/proc/acpi/sleep instead.

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

