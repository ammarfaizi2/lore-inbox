Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290826AbSAYXc3>; Fri, 25 Jan 2002 18:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290829AbSAYXcT>; Fri, 25 Jan 2002 18:32:19 -0500
Received: from smtp4.vol.cz ([195.250.128.43]:50184 "EHLO majordomo.vol.cz")
	by vger.kernel.org with ESMTP id <S290826AbSAYXcJ>;
	Fri, 25 Jan 2002 18:32:09 -0500
Date: Thu, 24 Jan 2002 23:12:05 +0100
From: Pavel Machek <pavel@suse.cz>
To: Britt Park <britt@drscience.sciencething.org>,
        Miklos.Szeredi@eth.ericsson.se
Cc: linux-kernel@vger.kernel.org
Subject: Re: UVFS Yet another user space filesystem kit.
Message-ID: <20020124221204.GA906@elf.ucw.cz>
In-Reply-To: <B871843F.200D%britt@sciencething.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B871843F.200D%britt@sciencething.org>
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I would like to announce the availability of version 0.1 of UVFS, yet
> another user space filesystem kit.  UVFS provide an interface to almost all
> kernel VFS methods in user space with acceptable overhead.  It comes with a
> sample in memory filesystem as documentation.
> 
> As far as I can determine UVFS is quite robust but I would love to have some
> independent confirmation of that.  I would also be delighted if someone more
> familiar with the linux VFS than I, were to give the code a once-over.
> 
> The current version of UVFS only supports a single instance of a given
> filesystem type.  That will be addressed in the next public release.
> 
> UVFS can be found at http://www.sciencething.org/geekthings/index.html .

How do you solve deadlocks on writing?

[Imagine so many dirty buffers are in memory that your
filesystem-in-userspace-daemon was swapped out?]

[Miklos, Cc-ed to you. You have that problem too. And it probably has
same solution like those untrusted filesystems -- back it up by a file.]
									Pavel


-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
