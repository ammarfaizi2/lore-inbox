Return-Path: <linux-kernel-owner+w=401wt.eu-S932386AbXAGErj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbXAGErj (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 23:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbXAGErj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 23:47:39 -0500
Received: from nigel.suspend2.net ([203.171.70.205]:45063 "EHLO
	nigel.suspend2.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932386AbXAGErj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 23:47:39 -0500
Subject: Re: [KORG] Re: kernel.org lies about latest -mm kernel
From: Nigel Cunningham <nigel@nigel.suspend2.net>
Reply-To: nigel@nigel.suspend2.net
To: Jeff Garzik <jeff@garzik.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, "J.H." <warthog9@kernel.org>,
       Randy Dunlap <randy.dunlap@oracle.com>, Andrew Morton <akpm@osdl.org>,
       Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       webmaster@kernel.org
In-Reply-To: <45A072C5.1080400@garzik.org>
References: <20061214223718.GA3816@elf.ucw.cz>
	 <20061216094421.416a271e.randy.dunlap@oracle.com>
	 <20061216095702.3e6f1d1f.akpm@osdl.org>  <458434B0.4090506@oracle.com>
	 <1166297434.26330.34.camel@localhost.localdomain>
	 <1166304080.13548.8.camel@nigel.suspend2.net> <459152B1.9040106@zytor.com>
	 <1168140954.2153.1.camel@nigel.suspend2.net>  <45A072C5.1080400@garzik.org>
Content-Type: text/plain
Date: Sun, 07 Jan 2007 15:47:37 +1100
Message-Id: <1168145257.2153.4.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Sat, 2007-01-06 at 23:10 -0500, Jeff Garzik wrote:
> Nigel Cunningham wrote:
> > Hi.
> > 
> > On Tue, 2006-12-26 at 08:49 -0800, H. Peter Anvin wrote:
> >> Nigel Cunningham wrote:
> >>> Hi.
> >>>
> >>> I've have git trees against a few versions besides Linus', and have just
> >>> moved all but Linus' to staging to help until you can get your new
> >>> hardware. If others were encouraged to do the same, it might help a lot?
> >>>
> >> Not really.  In fact, it would hardly help at all.
> >>
> >> The two things git users can do to help is:
> >>
> >> 1. Make sure your alternatives file is set up correctly;
> >> 2. Keep your trees packed and pruned, to keep the file count down.
> >>
> >> If you do this, the load imposed by a single git tree is fairly negible.
> > 
> > Sorry for the slow reply, and the ignorance... what's an alternatives
> > file? I've never heard of them before.
> 
> It's highly useful but poorly documented method of referencing 
> repository B's objects from repository A.
> 
> When you clone locally
> 
> 	git clone --reference linus-2.6 linus-2.6 nigel-2.6
> 
> it will create nigel-2.6 with zero objects, and an alternatives file 
> pointing to 'linus-2.6' local repository.  When you commit, only the 
> objects not already in linus-2.6 will be found in nigel-2.6.
> 
> It's far better "git clone -l ..." because you don't even have the 
> additional hardlinked inodes, and don't have to run "git relink" locally.

Cool. I'll have a play :)

Thanks!

Nigel

