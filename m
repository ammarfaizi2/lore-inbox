Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267805AbTBKNCA>; Tue, 11 Feb 2003 08:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267789AbTBKNCA>; Tue, 11 Feb 2003 08:02:00 -0500
Received: from node181b.a2000.nl ([62.108.24.27]:14755 "EHLO ddx.a2000.nu")
	by vger.kernel.org with ESMTP id <S267597AbTBKNB7>;
	Tue, 11 Feb 2003 08:01:59 -0500
Date: Tue, 11 Feb 2003 14:11:10 +0100 (CET)
From: Stephan van Hienen <raid@a2000.nu>
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       "Theodore Ts'o" <tytso@mit.edu>, peter@chubb.wattle.id.au, tbm@a2000.nu
Subject: Re: [Ext2-devel] Re: fsck out of memory
In-Reply-To: <1044917060.11838.108.camel@sisko.scot.redhat.com>
Message-ID: <Pine.LNX.4.53.0302111410350.13269@ddx.a2000.nu>
References: <Pine.LNX.4.53.0302071555110.718@ddx.a2000.nu>
 <Pine.LNX.4.53.0302071800200.1306@ddx.a2000.nu> <20030207102858.P18636@schatzie.adilger.int>
  <Pine.LNX.4.53.0302090953440.1039@ddx.a2000.nu> <1044917060.11838.108.camel@sisko.scot.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Feb 2003, Stephen C. Tweedie wrote:

> On Sun, 2003-02-09 at 10:08, Stephan van Hienen wrote:
>
> > Feb  7 04:18:15 storage kernel: EXT3-fs error (device md(9,0)):
> > ext3_new_block:
> > Allocating block in system zone - block = 536875638
>
> That looks like it could be a block wrap, amongst other possible causes.
hmms and this means ?


>
> > makes me wonder if this can have todo with the lbd (to allow 2TB+ devices)
> > patch ? or is this something else?
>
> Well, that's the most likely candidate, because it's the least tested
> component.  Are you using Ben LaHaise's LBD fixes for the md devices?
> Without those, md and lvm are not LBD-safe.
where can i find this lbd fixes for md ?
