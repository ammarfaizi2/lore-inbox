Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264600AbRFPJ6x>; Sat, 16 Jun 2001 05:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264601AbRFPJ6o>; Sat, 16 Jun 2001 05:58:44 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:32004 "EHLO
	bug.ucw.cz") by vger.kernel.org with ESMTP id <S264600AbRFPJ6d>;
	Sat, 16 Jun 2001 05:58:33 -0400
Date: Thu, 14 Jun 2001 13:01:16 +0000
From: Pavel Machek <pavel@suse.cz>
To: Russ Lewis <russl@lycosmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Has it been done: User Script File System?
Message-ID: <20010614130115.A33@toy.ucw.cz>
In-Reply-To: <3B27A546.A64F8B00@lycosmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3B27A546.A64F8B00@lycosmail.com>; from russl@lycosmail.com on Wed, Jun 13, 2001 at 10:39:19AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Is there any filesystem in Linux that uses user scripts/executables to
> implement the various function calls?  What I'm thinking of is something
> along the lines of a file system module that, when it receives a call
> from VFS, passes the information out to a user-mode daemon which could
> then run scripts or executables to answer the question.  The daemon
> would then return the answer to the module, and the module would answer
> VFS.

Take a look at uservfs.sourceforge.net. Its extfs module is basically what
you want. zipfs is already implemented using script...
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

