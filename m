Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264268AbTLPBWD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 20:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264273AbTLPBWD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 20:22:03 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:34633 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S264268AbTLPBWB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 20:22:01 -0500
Date: Tue, 16 Dec 2003 12:21:14 +1100
From: Nathan Scott <nathans@sgi.com>
To: Eric Sandeen <sandeen@sgi.com>,
       Emilio Gargiulo <emiliogargiulo@supereva.it>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: 2.4.24-pre1 hangs with XFS on LVM filesystem full
Message-ID: <20031216012114.GA566@frodo>
References: <Pine.LNX.4.44.0312132302520.766-100000@stout.americas.sgi.com> <200312152200.08411.emiliogargiulo@supereva.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312152200.08411.emiliogargiulo@supereva.it>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 15, 2003 at 10:00:08PM +0100, Emilio Gargiulo wrote:
> Yes, a simple overfill of a XFS filesystem on LVM hangs the kernel.
> It is easy to reproduce with dd if=/dev/zero of=file_on_dest_xfs_filesystem 
> bs=1024k.
> ...
> I compiled the kernel with gcc 3.2.3. (Slackware 9.1)
> I am unable to reproduce the problem if I compile the kernel with gcc 3.3.1.

Hmm, that would seem to be an important piece of information -
could be a gcc-3.2.3 compiler bug.  Since noone here is able to
trigger this problem with other compilers too (and under a lot
more varied conditions around the ENOSPC boundaries), I suppose
a gcc bug is a real possibility here.

cheers.

-- 
Nathan
