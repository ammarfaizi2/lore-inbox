Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290752AbSARQtB>; Fri, 18 Jan 2002 11:49:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290745AbSARQrV>; Fri, 18 Jan 2002 11:47:21 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:22539 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S290739AbSARQrC>;
	Fri, 18 Jan 2002 11:47:02 -0500
Date: Sun, 13 Jan 2002 03:10:53 +0000
From: Pavel Machek <pavel@suse.cz>
To: Miklos Szeredi <Miklos.Szeredi@eth.ericsson.se>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        avfs@fazekas.hu
Subject: Re: [ANNOUNCE] FUSE: Filesystem in Userspace 0.95
Message-ID: <20020113031052.I511@toy.ucw.cz>
In-Reply-To: <200201100955.KAA19208@duna207.danubius>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200201100955.KAA19208@duna207.danubius>; from Miklos.Szeredi@eth.ericsson.se on Thu, Jan 10, 2002 at 10:55:09AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> FUSE 0.95 is available (download or CVS) from:
> 
>    http://sourceforge.net/projects/avf

(I'm offline, that's why I'm asking like that):

> What's new in 0.95 compared to 0.9
> 
>    - Major performance improvements in both the kernel module and the
>      library parts.
> 
>    - Small number of bugs fixed.  FUSE has been through some stress
>      testing and no problems have turned up yet.
> 
>    - Library interface simplified.  A simple 'hello world' filesystem
>      can now be implemented in less than 100 lines.

Are you multithreaded? Like will big ftp download block all FUSE, all ftp,
only one server, or everything?

>    - Python (by Jeff Epler) and Perl (by Mark Glines) bindings are in
>      the works, and will be released some time in the future (now
>      available through CVS).

Nice!

> Problems still remaining:
> 
>    - Security problems when fuse is used by non-privileged users:
> 
>        o user can intentionally block the page writeback operation,
>          causing a system lockup.  I'm not sure this can be solved in
>          a truly secure way.  Ideas?

How does GRUB solve this?

> Introduction for newbies:
> 
>   FUSE provides a simple interface for userspace programs to export a
>   virtual filesystem to the Linux kernel.  FUSE also aims to provide a
>   secure method for non privileged users to create and mount their own
>   filesystem implementations.
> 
>   Fuse is available for the 2.4 (and later) kernel series.
>   Installation is easy and does not need a kernel recompile.

Maybe it could replace sf/coda and fs/intermezzo? Is it powerfull/fast
enough for that?
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

