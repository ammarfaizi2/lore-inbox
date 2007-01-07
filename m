Return-Path: <linux-kernel-owner+w=401wt.eu-S965125AbXAGUMb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965125AbXAGUMb (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 15:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965121AbXAGUMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 15:12:31 -0500
Received: from mail.suse.de ([195.135.220.2]:49111 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965073AbXAGUMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 15:12:30 -0500
Date: Sun, 7 Jan 2007 12:11:46 -0800
From: Greg KH <gregkh@suse.de>
To: Jeff Garzik <jeff@garzik.org>
Cc: nigel@nigel.suspend2.net, "H. Peter Anvin" <hpa@zytor.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       "J.H." <warthog9@kernel.org>, Randy Dunlap <randy.dunlap@oracle.com>,
       Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       webmaster@kernel.org, Git Mailing List <git@vger.kernel.org>
Subject: Re: [KORG] Re: kernel.org lies about latest -mm kernel
Message-ID: <20070107201146.GA21956@suse.de>
References: <20061214223718.GA3816@elf.ucw.cz> <20061216094421.416a271e.randy.dunlap@oracle.com> <20061216095702.3e6f1d1f.akpm@osdl.org> <458434B0.4090506@oracle.com> <1166297434.26330.34.camel@localhost.localdomain> <1166304080.13548.8.camel@nigel.suspend2.net> <459152B1.9040106@zytor.com> <1168140954.2153.1.camel@nigel.suspend2.net> <45A07587.3080503@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45A07587.3080503@garzik.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 06, 2007 at 11:22:31PM -0500, Jeff Garzik wrote:
> >On Tue, 2006-12-26 at 08:49 -0800, H. Peter Anvin wrote:
> >>Not really.  In fact, it would hardly help at all.
> >>
> >>The two things git users can do to help is:
> >>
> >>1. Make sure your alternatives file is set up correctly;
> >>2. Keep your trees packed and pruned, to keep the file count down.
> >>
> >>If you do this, the load imposed by a single git tree is fairly negible.
> 
> 
> Would kernel hackers be amenable to having their trees auto-repacked, 
> and linked via alternatives to Linus's linux-2.6.git?
> 
> Looking through kernel.org, we have a ton of repositories, however 
> packed, that carrying their own copies of the linux-2.6.git repo.

Well, I create my repos by doing a:
	git clone -l --bare
which makes a hardlink from Linus's tree.

But then it gets copied over to the public server, which probably severs
that hardlink :(

Any shortcut to clone or set up a repo using "alternatives" so that we
don't have this issue at all?

thanks,

greg k-h
