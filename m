Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290175AbSAWWqA>; Wed, 23 Jan 2002 17:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289970AbSAWWpn>; Wed, 23 Jan 2002 17:45:43 -0500
Received: from smtp4.vol.cz ([195.250.128.43]:65292 "EHLO majordomo.vol.cz")
	by vger.kernel.org with ESMTP id <S289619AbSAWWp2>;
	Wed, 23 Jan 2002 17:45:28 -0500
Date: Wed, 23 Jan 2002 11:47:52 +0100
From: Pavel Machek <pavel@suse.cz>
To: Miklos Szeredi <Miklos.Szeredi@eth.ericsson.se>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        avfs@fazekas.hu
Subject: Re: [ANNOUNCE] FUSE: Filesystem in Userspace 0.95
Message-ID: <20020123104752.GA965@elf.ucw.cz>
In-Reply-To: <200201100955.KAA19208@duna207.danubius> <20020113031052.I511@toy.ucw.cz> <200201211018.LAA08707@duna207.danubius>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200201211018.LAA08707@duna207.danubius>
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Are you multithreaded? Like will big ftp download block all FUSE, all ftp,
> > only one server, or everything?
> 
> FUSE and AVFS are both multithreaded.  Specifically ftp is quite well
> threaded, and a big download will not block any operation, even on the
> same server. 

Good!

> > >        o user can intentionally block the page writeback operation,
> > >          causing a system lockup.  I'm not sure this can be solved in
> > >          a truly secure way.  Ideas?
> > 
> > How does GRUB solve this?
> 
> What GRUB? 

Sorry, I meant HURD. It has "untrusted" filesystems in userland, too.
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
