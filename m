Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264254AbTEGT1P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 15:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264244AbTEGT1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 15:27:15 -0400
Received: from adsl-216-102-214-42.dsl.snfc21.pacbell.net ([216.102.214.42]:16140
	"EHLO cynthia.pants.nu") by vger.kernel.org with ESMTP
	id S264252AbTEGT1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 15:27:01 -0400
Date: Wed, 7 May 2003 12:39:32 -0700
From: Brad Boyer <flar@allandria.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-hfsplus-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] HFS+ driver
Message-ID: <20030507193932.GA17068@pants.nu>
References: <Pine.LNX.4.44.0305071643030.5042-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305071643030.5042-100000@serv>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 07, 2003 at 05:06:59PM +0200, Roman Zippel wrote:
> I'm proud to announce a complete new version of the HFS+ fs driver. This 
> work was made possible by Ardis Technologies (www.ardistech.com). It's 
> based on the driver by Brad Boyer (http://sf.net/projects/linux-hfsplus).

I was starting to think noone was ever going to help out.  :)

If you don't mind, I'll start merging your changes into the CVS tree
on SourceForge. I assume this is all GPL code, since you started from
my original patches... I'll wait to hear back from you before merging
it in, since it's a pretty big change.

> The new driver now supports full read and write access. Perfomance has 
> improved a lot, the btrees are kept in the page cache with a hash on top 
> of this to speed up the access to the btree nodes.
> I also added support for hard links and the resource fork is accessible 
> via <file>/rsrc.

These were features I was trying to put off until someone else was
a little more active, I have to admit. I've been working on the code
in between other projects, but I'm a terrible release engineer and
other stuff got more interesting. It's good to see that someone else
cares about it.

	Brad Boyer
	flar@allandria.com

