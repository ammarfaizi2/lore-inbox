Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283588AbRLTKKM>; Thu, 20 Dec 2001 05:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283655AbRLTKKB>; Thu, 20 Dec 2001 05:10:01 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:36878 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S283588AbRLTKJt>; Thu, 20 Dec 2001 05:09:49 -0500
Date: Thu, 20 Dec 2001 11:09:36 +0100
From: Pavel Machek <pavel@suse.cz>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Pavel Machek <pavel@suse.cz>, "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Quinn Harris <quinn@nmt.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: File copy system call proposal
Message-ID: <20011220110936.A18142@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200112100544.fBA5isV223458@saturn.cs.uml.edu> <20011213030107.L940@lynx.no> <20011213221712.A129@elf.ucw.cz> <E16GnIg-0000V5-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16GnIg-0000V5-00@starship.berlin>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Consider the _very_ common case (that nobody has mentioned yet) where you
> > > are editing a large file.  When you write to the file, the editor copies
> > > the file to a backup, then immediately truncates the original file and
> > > writes the new data there.  What would be _far_ preferrable is to
> > > just
> > 
> > Are you sure? I think editor just _moves_ original to backup.
> 
> Hi,
> 
> It would be so nice if all editors did that, but most don't according to the 
> tests I've done, especially the newer ones like kedit, gnome-edit etc.  I 
> think this is largely due to developers not knowing why it's good to do it 
> this way.

They need to get a clue. No need to work around their bugs in kernel.

Anyway copyfile syscall would be nice for other reasons. (cp -a kernel
tree then apply patch without waiting for physical copy to be done
would be handy).
								Pavel
-- 
Casualities in World Trade Center: 6453 dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
