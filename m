Return-Path: <linux-kernel-owner+w=401wt.eu-S1750804AbXAHXtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbXAHXtD (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 18:49:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbXAHXtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 18:49:03 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:49835 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750804AbXAHXtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 18:49:00 -0500
Date: Tue, 9 Jan 2007 00:34:49 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andrew Morton <akpm@osdl.org>
cc: Shaya Potter <spotter@cs.columbia.edu>,
       "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, viro@ftp.linux.org.uk, torvalds@osdl.org,
       mhalcrow@us.ibm.com, David Quigley <dquigley@fsl.cs.sunysb.edu>,
       Erez Zadok <ezk@cs.sunysb.edu>
Subject: Re: [PATCH 01/24] Unionfs: Documentation
In-Reply-To: <20070108140224.3a814b7d.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0701090031220.20773@yvahk01.tjqt.qr>
References: <1168229596580-git-send-email-jsipek@cs.sunysb.edu>
 <1168229596875-git-send-email-jsipek@cs.sunysb.edu> <20070108111852.ee156a90.akpm@osdl.org>
 <Pine.LNX.4.63.0701081442230.19059@razor.cs.columbia.edu>
 <20070108131957.cbaf6736.akpm@osdl.org> <1168291848.9853.1.camel@localhost.localdomain>
 <20070108140224.3a814b7d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jan 8 2007 14:02, Andrew Morton wrote:
>Shaya Potter <spotter@cs.columbia.edu> wrote:
>> 
>> the difference is bind mounts are a vfs construct, while unionfs is a
>> file system.
>
>Well yes.  So the top-level question is "is this the correct way of doing
>unionisation?".
>I suspect not, in which case unionfs is at best a stopgap until someone
>comes along and implements unionisation at the VFS level, at which time
>unionfs goes away.

Not either. I *think* Jan Blunck wrote a pdf-paper about 'union mounts', i.e.
the vfs construct you refer to. [
http://www.free-it.org/archiv/talks_2005/paper-11254/paper-11254.pdf looks like
it ]
However, it's not duplicating a namespace, hence, unionfs also has a
right to exist.


>a) is unionfs a sufficiently useful stopgap to justify a merge and
>
>b) would an interim merge of unionfs increase or decrease the motivation
>   for someone to do a VFS implementation?
>
>I suspect the answer to b) is "increase": if unionfs proves to be useful
>then people will be motivated to produce more robust implementations of the
>same functionality.  If it proves to not be very useful then nobody will
>bother doing anything, which in a way would be a useful service.

Fact is, when it's in, bugs could be shaken out. Though then I think what
better AUFS could do.


	-`J'
-- 
