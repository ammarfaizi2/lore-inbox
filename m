Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261421AbUJaULC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbUJaULC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 15:11:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261427AbUJaULC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 15:11:02 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:8280 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261421AbUJaUK6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 15:10:58 -0500
Date: Sun, 31 Oct 2004 22:10:51 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Dan Kegel <dank@kegel.com>, Sam Ravnborg <sam@ravnborg.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Martin Schaffner <schaffner@gmx.li>, Kevin Hilman <kjh@hilman.org>,
       bertrand marquis <bertrand.marquis@sysgo.com>
Subject: Re: Building on case-insensitive systems and systems where -shared doesn't work well (was: Re: 2.6.8 link failure for sparc32 (vmlinux.lds.s: No such file or directory)?)
Message-ID: <20041031211051.GA20098@mars.ravnborg.org>
Mail-Followup-To: Dan Kegel <dank@kegel.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Martin Schaffner <schaffner@gmx.li>, Kevin Hilman <kjh@hilman.org>,
	bertrand marquis <bertrand.marquis@sysgo.com>
References: <414FC41B.7080102@kegel.com> <58517.194.237.142.24.1095763849.squirrel@194.237.142.24> <4164DAC9.8080701@kegel.com> <20041016210024.GB8306@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041016210024.GB8306@mars.ravnborg.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 16, 2004 at 11:00:24PM +0200, Sam Ravnborg wrote:
 
> > This one's after an idea by bertrand.marquis@sysgo.com,
> > but it's small enough to be considered trivial.  Many OS's
> > don't support shared libraries as easily as Linux does,
> > and there's nothing to be gained by making libkconfig shared, so don't.
> > http://www.kegel.com/crosstool/crosstool-0.28-rc37/patches/linux-2.6.8/linux-2.6.8-noshared-kconfig.patch
> > 
> 
> I will give this a try - and apply if I see no problems.

Applied in a slightly simpler version.

	Sam
