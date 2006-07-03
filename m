Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751066AbWGCU01@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbWGCU01 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 16:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751077AbWGCU01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 16:26:27 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:56210 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1751066AbWGCU00
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 16:26:26 -0400
Date: Mon, 3 Jul 2006 22:22:19 +0200
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       "Theodore Ts'o" <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: ext4 features
Message-ID: <20060703202219.GA9707@aitel.hist.no>
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de> <20060701170729.GB8763@irc.pl> <20060701174716.GC24570@cip.informatik.uni-erlangen.de> <20060701181702.GC8763@irc.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060701181702.GC8763@irc.pl>
User-Agent: Mutt/1.5.11+cvs20060403
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 01, 2006 at 08:17:02PM +0200, Tomasz Torcz wrote:
> On Sat, Jul 01, 2006 at 07:47:16PM +0200, Thomas Glanzmann wrote:
> > Hello,
> > 
> > > Checksums are not very useful for themselves. They are useful when we
> > > have other copy of data (think raid mirroring) so data can be
> > > reconstructed from working copy.
> > 
> > it would be possible to identify data corruption.
> > 
> 
>   Yes, but what good is identification? We could only return I/O error.
> Ability to fix corruption (like ZFS) is the real killer.

Isn't that what we have RAID-1/5/6 for?  

Helge Hafting

