Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbWGXLdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWGXLdo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 07:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbWGXLdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 07:33:44 -0400
Received: from [83.221.155.181] ([83.221.155.181]:42137 "EHLO
	zeus.sikkerhed.org") by vger.kernel.org with ESMTP id S932107AbWGXLdn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 07:33:43 -0400
From: Christian Iversen <chrivers@iversen-net.dk>
To: Hans Reiser <reiser@namesys.com>, lkml@lpbproductions.com,
       Jeff Garzik <jeff@garzik.org>, Theodore Tso <tytso@mit.edu>,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion
Date: Mon, 24 Jul 2006 13:34:11 +0200
User-Agent: KMail/1.9.1
References: <44C12F0A.1010008@namesys.com> <44C4813E.2030907@namesys.com> <20060724102508.GA26553@merlin.emma.line.org>
In-Reply-To: <20060724102508.GA26553@merlin.emma.line.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607241334.12218.chrivers@iversen-net.dk>
X-Spam-Score: -1.871
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 24 July 2006 12:25, Matthias Andree wrote:
> On Mon, 24 Jul 2006, Hans Reiser wrote:
> > >and that's the end
> > >of the story for me. There's nothing wrong about focusing on newer code,
> > >but the old code needs to be cared for, too, to fix remaining issues
> > >such as the "can only have N files with the same hash value".
> >
> > Requires a disk format change, in a filesystem without plugins, to fix
> > it.
>
> You see, I don't care a iota about "plugins" or other implementation
> details.
>
> The bottom line is reiserfs 3.6 imposes practial limits that ext3fs
> doesn't impose and that's reason enough for an administrator not to
> install reiserfs 3.6. Sorry.

And what do you do if you, say, run of of inodes on ext3? Do you think the 
users will care about that? Or what if the number of files in your mail queue 
or proxy cache* become large enough for your fs operations to slow to a 
crawl?


* Yes I know most programs work around this by using many subdirs, but that's 
really a bandaid solution.

-- 
Regards,
Christian Iversen
