Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbUJPTGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbUJPTGh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 15:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbUJPTGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 15:06:37 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:1298 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261474AbUJPTGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 15:06:35 -0400
Date: Sat, 16 Oct 2004 20:06:27 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Dan Kegel <dank@kegel.com>, Sam Ravnborg <sam@ravnborg.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Martin Schaffner <schaffner@gmx.li>, Kevin Hilman <kjh@hilman.org>,
       bertrand marquis <bertrand.marquis@sysgo.com>
Subject: Re: Building on case-insensitive systems and systems where -shared doesn't work well (was: Re: 2.6.8 link failure for sparc32 (vmlinux.lds.s: No such file or directory)?)
Message-ID: <20041016200627.A20488@flint.arm.linux.org.uk>
Mail-Followup-To: Dan Kegel <dank@kegel.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Martin Schaffner <schaffner@gmx.li>, Kevin Hilman <kjh@hilman.org>,
	bertrand marquis <bertrand.marquis@sysgo.com>
References: <414FC41B.7080102@kegel.com> <58517.194.237.142.24.1095763849.squirrel@194.237.142.24> <4164DAC9.8080701@kegel.com> <20041016210024.GB8306@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041016210024.GB8306@mars.ravnborg.org>; from sam@ravnborg.org on Sat, Oct 16, 2004 at 11:00:24PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 16, 2004 at 11:00:24PM +0200, Sam Ravnborg wrote:
> On Wed, Oct 06, 2004 at 10:57:29PM -0700, Dan Kegel wrote:
> > Sam Ravnborg wrote:
> > >On Tue, Sep 21, 2004 at 10:40:24PM -0700, Dan Kegel wrote:
> > >>    683    2328   27265 linux-2.6.8-build_on_case_insensitive_fs-1.patch
> > >>     28     122    1028 linux-2.6.8-noshared-kconfig.patch
> > >
> > >Can you please post these two patches.
> > >The fist I hope is very small today.
> > 
> > OK, here they are, plus a third one that also seems neccessary:
> > 
> > This one's by Martin Schaffner:
> > http://www.kegel.com/crosstool/crosstool-0.28-rc37/patches/linux-2.6.8/linux-2.6.8-build_on_case_insensitive_fs.patch
> > 
> Most of this is done in current linus-BK. I'm planning to handle
> asm-offset in another way and will then start to get rid of .S -> .s

Converting .S -> .s is useful for debugging - please don't cripple the
kernel developers just because some filesystems are case-challenged.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
