Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262902AbVDHRhQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262902AbVDHRhQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 13:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262898AbVDHRhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 13:37:15 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11223 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262893AbVDHRgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 13:36:18 -0400
Message-ID: <4256C0F8.6030008@pobox.com>
Date: Fri, 08 Apr 2005 13:35:52 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Matthias-Christian Ott <matthias.christian@tiscali.de>,
       Andrea Arcangeli <andrea@suse.de>, Chris Wedgwood <cw@f00f.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org> <20050408041341.GA8720@taniwha.stupidest.org> <Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org> <20050408071428.GB3957@opteron.random> <Pine.LNX.4.58.0504080724550.28951@ppc970.osdl.org> <4256AE0D.201@tiscali.de> <Pine.LNX.4.58.0504081010540.28951@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504081010540.28951@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Warning: 24.25.22.197 is listed at orbz.gst-group.uk.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Fri, 8 Apr 2005, Matthias-Christian Ott wrote:
> 
>>SQL Databases like SQLite aren't slow.
> 
> 
> After applying a patch, I can do a complete "show-diff" on the kernel tree
> to see the effect of it in about 0.15 seconds.
> 
> Also, I can use rsync to efficiently replicate my database without having 
> to re-send the whole crap - it only needs to send the new stuff.
> 
> You do that with an sql database, and I'll be impressed.

Well...  it took me over 30 seconds just to 'rm -rf' the unpacked 
tarballs of git and sparse-git, over my LAN's NFS.

Granted that this sort of stuff works well with (a) rsync and (b) 
hardlinks, but it's still punishment on the i/dcache.

	Jeff



