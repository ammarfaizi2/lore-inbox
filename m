Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262276AbVDXHWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262276AbVDXHWa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 03:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262278AbVDXHWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 03:22:30 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:64234 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262276AbVDXHW0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 03:22:26 -0400
Date: Sun, 24 Apr 2005 09:21:00 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Petr Baudis <pasky@ucw.cz>
Cc: Linus Torvalds <torvalds@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.12-rc3
Message-ID: <20050424072100.GA1908@elf.ucw.cz>
References: <20050421120327.GA13834@elf.ucw.cz> <20050421162220.GD30991@pasky.ji.cz> <20050421232201.GD31207@elf.ucw.cz> <20050422002150.GY7443@pasky.ji.cz> <20050422231839.GC1789@elf.ucw.cz> <Pine.LNX.4.58.0504221718410.2344@ppc970.osdl.org> <20050423111900.GA2226@openzaurus.ucw.cz> <Pine.LNX.4.58.0504230654190.2344@ppc970.osdl.org> <20050423230023.GA17388@elf.ucw.cz> <20050423230648.GE13222@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050423230648.GE13222@pasky.ji.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Ne 24-04-05 01:06:48, Petr Baudis wrote:
> Dear diary, on Sun, Apr 24, 2005 at 01:00:23AM CEST, I got a letter
> where Pavel Machek <pavel@ucw.cz> told me that...
> > I created three trees here (with git fork): one ("clean-git") to track
> > your changes, second ("linux-git") to do my development on and third
> > ("linux-good") for good, nice, cleaned-up changes, for you to merge.
> > 
> > ...unfortunately pasky's git just symlinked object/ directories...
> 
> You can't do any better than that, since you would have to transfer
> stuff around by pulling them otherwise; so you would need smart git
> pull, but then Linus can use the smart git pull himself anyway. ;-)

Actually, no.

Without cherypicking, I just can't pull from linux-git into
linux-good. Ever. linux-git contains some changes that just can not go
anywhere. (Like for example czech-ucw-defkeymap.map)

So it should be okay to just copy object directories instead of
linking them. Or perhaps cp -al is good idea here. (It also removes
trap where I rm -rf-ed tree I did fork from....)

Heh, filesystem with auto-file-hardlinking would be nice there ;-).
 
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
