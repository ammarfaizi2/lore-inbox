Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285460AbRLSUPU>; Wed, 19 Dec 2001 15:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285456AbRLSUPK>; Wed, 19 Dec 2001 15:15:10 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:4105 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S285454AbRLSUO6>;
	Wed, 19 Dec 2001 15:14:58 -0500
Date: Thu, 13 Dec 2001 22:17:12 +0100
From: Pavel Machek <pavel@suse.cz>
To: Daniel Phillips <phillips@bonn-fries.net>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Quinn Harris <quinn@nmt.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: File copy system call proposal
Message-ID: <20011213221712.A129@elf.ucw.cz>
In-Reply-To: <200112100544.fBA5isV223458@saturn.cs.uml.edu> <E16DSDU-0001EN-00@starship.berlin> <20011213030107.L940@lynx.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011213030107.L940@lynx.no>
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> No, I think he means just the opposite - that having a "copy(2)" syscall
> would greatly _help_ SMB in that the copy could be done entirely at the
> server side, rather than having to pull _all_ of the data to the client
> and then sending it back again.
> 
> When I was working on another network storage system (formerly called
> Lustre, don't know what it is called now) we had a "copy" primitive in
> the VFS interface, and there were lots of useful things you could do
> with it.
> 
> Consider the _very_ common case (that nobody has mentioned yet) where you
> are editing a large file.  When you write to the file, the editor copies
> the file to a backup, then immediately truncates the original file and
> writes the new data there.  What would be _far_ preferrable is to
> just

Are you sure? I think editor just _moves_ original to backup.
								Pavel

-- 
"I do not steal MS software. It is not worth it."
                                -- Pavel Kankovsky
