Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751501AbWB0RHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbWB0RHi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 12:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751502AbWB0RHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 12:07:38 -0500
Received: from [198.99.130.12] ([198.99.130.12]:47068 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751501AbWB0RHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 12:07:37 -0500
Date: Mon, 27 Feb 2006 12:08:26 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: fuse-devel@lists.sourceforge.net,
       user-mode-linux-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] [Announce] mountlo 0.5 - Loopback mounting in userspace
Message-ID: <20060227170826.GA5481@ccure.user-mode-linux.org>
References: <E1FDk1G-0004S6-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1FDk1G-0004S6-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2006 at 04:10:38PM +0100, Miklos Szeredi wrote:
> I'm proud to announce a new version of my pet project 'mountlo', a
> utility which works similarly to 'mount -o loop', but the filesystem
> runs entirely in userspace.
> 
> While arguably it is quite useless, I like it because it combines some
> of my favorite technologies (Linux, UML and FUSE) with very little
> additional glue code.

Very cute.  I'm in the process of doing something similar, except I'm
integrating a FUSE server into the UML kernel to export the UML
filesystem to the host.  So far, I can cd and ls inside the mount -
lookup and readdir are implemented.

				Jeff
