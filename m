Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268608AbUHLQjm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268608AbUHLQjm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 12:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268523AbUHLQjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 12:39:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:656 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268609AbUHLQjZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 12:39:25 -0400
Date: Thu, 12 Aug 2004 09:39:22 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SG_IO and security
In-Reply-To: <1092313030.21978.34.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0408120929360.1839@ppc970.osdl.org>
References: <1092313030.21978.34.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 12 Aug 2004, Alan Cox wrote:
>
> Since the entire thread seems to have died again unresolved I'd suggest
> the following patch should get into 2.6.8 so that anyone with read
> access to any block device cannot issue arbitary scsi commands to it
> (like writes or firmware erase)

Hmm.. This still allows the old "junk" commands (SCSI_IOCTL_SEND_COMMAND).

I'll add that too.

		Linus
