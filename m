Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313022AbSDGKBf>; Sun, 7 Apr 2002 06:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313023AbSDGKBe>; Sun, 7 Apr 2002 06:01:34 -0400
Received: from [195.39.17.254] ([195.39.17.254]:5514 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S313022AbSDGKBe>;
	Sun, 7 Apr 2002 06:01:34 -0400
Date: Sun, 7 Apr 2002 11:58:44 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Ed Sweetman <ed.sweetman@wmich.edu>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org,
        swsusp@lister.fornax.hu
Subject: Re: Linux 2.4.19pre5-ac3 swsusp panic
Message-ID: <20020407095844.GA216@elf.ucw.cz>
In-Reply-To: <200204060109.g36199g10373@devserv.devel.redhat.com> <1018114652.7477.2.camel@psuedomode> <1018116297.7477.21.camel@psuedomode>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > On WOLK 3.2 i use swsusp and it works just fine on my P4 system.  With
> > the ac kernel i get a panic whenever i try to suspend.  I tried
> > including the couple lines that i patched in WOLK 3.2's swsusp mentioned
> > in the swsusp mailing list and still it panics.  Perhaps it's due to the
> > Taskfile stuff i compiled with, i'll try it without that stuff next. 
> > 
> > 
> > wish i could take a screenshot of the panic
> 
> 
> No, taskfile did nothing.
> 
> here's all i can see on my screen when executing a suspend I had to type
> it up by hand so, hopefully no mistakes. 

Reproduced here, and hunting that bug.
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
