Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287558AbSAHCJZ>; Mon, 7 Jan 2002 21:09:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287511AbSAHCJP>; Mon, 7 Jan 2002 21:09:15 -0500
Received: from codeblau.walledcity.de ([212.84.209.34]:59147 "EHLO codeblau.de")
	by vger.kernel.org with ESMTP id <S287565AbSAHCJE>;
	Mon, 7 Jan 2002 21:09:04 -0500
Date: Tue, 8 Jan 2002 03:09:15 +0100
From: Felix von Leitner <felix-dietlibc@fefe.de>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, dietlibc@fefe.de
Subject: Re: [ANNOUNCE] klibc 0.1 release
Message-ID: <20020108020915.GA13168@codeblau.de>
Mail-Followup-To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	dietlibc@fefe.de
In-Reply-To: <20020108014100.GD10145@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020108014100.GD10145@kroah.com>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus spake Greg KH (greg@kroah.com):
> As many people have recently realized, it looks like we need to have
> some kind of klibc library for the initramfs programs due to problems
> with the existing libc implementations (if people disagree with this,
> please feel free to speak up.)

> With this in mind, I took the work that I did to merge dietLibc into the
> dietHotplug build process, and created a first snapshot of a klibc
> project.  I have successfully used it to build a version of dietHotplug,
> but that's probably about all that will build against the library at
> this time :)

I wonder if it is wise to fork the project.
The diet libc does not yet work for all platforms; work is underway but
as yet incomplete on S/390, and no sh-linux and no ia64-linux at all.

I understand that's OK for diet hotplug, so it's OK to take just enough
code to make your project work.  The important question probably is
whether diet hotplug will be part of the kernel distribution or not.
If not, I don't think it makes much sense to not just reference the diet
libc.  Maybe we can put the diet libc distribution on ftp.kernel.org to
show the affinity better (and make it more widely mirrored).

But forking means you will have to watch our CVS and port stuff from
here to there every now and then.

Compared to the kernel sources, the diet libc tarball is two orders of
magnitude smaller, so I am not sure I understand the need to make it
even smaller.

Felix
