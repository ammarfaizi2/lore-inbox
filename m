Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964847AbWHCQkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964847AbWHCQkX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 12:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbWHCQkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 12:40:23 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:64782 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964847AbWHCQkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 12:40:23 -0400
Date: Thu, 3 Aug 2006 18:40:19 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Avuton Olrich <avuton@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Antonino Daplas <adaplas@pol.net>
Subject: Re: Linux v2.6.18-rc3
Message-ID: <20060803164019.GD25692@stusta.de>
References: <Pine.LNX.4.64.0607292320490.4168@g5.osdl.org> <3aa654a40608030858n7f1643adw28502b41f4bfdace@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3aa654a40608030858n7f1643adw28502b41f4bfdace@mail.gmail.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 08:58:57AM -0700, Avuton Olrich wrote:
> On 7/29/06, Linus Torvalds <torvalds@osdl.org> wrote:
> >
> >Ok, this missed a week (it should really have been -rc4, and we should
> >have had a -rc3 a week ago), but the fact is, with a lot of people at the
> >kernel summit and at OLS, it was so quiet for a week that there simply was
> >no point.
> 
> Got a warning with -rc3:
> WARNING: "fb_register_client" [drivers/video/backlight/backlight.ko] 
> undefined!
> WARNING: "fb_unregister_client" [drivers/video/backlight/backlight.ko]
> undefined!
> 
> I'm not sure who the maintainer is. I don't really need it, just
> wanted someone to be aware. config attached.

Thanks for your report.

This issue should already be fixed in Linus' tree by commit 
256154fbc31c25a8df4d398232acfa9d4892224c.

> avuton

cu
Adrian

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli

