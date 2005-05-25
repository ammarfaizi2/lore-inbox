Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbVEYQMv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbVEYQMv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 12:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbVEYQMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 12:12:51 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:5060 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261347AbVEYQMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 12:12:47 -0400
Date: Wed, 25 May 2005 12:12:47 -0400
To: Kurt Wall <kwall@kurtwerks.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ide-cd vs. DMA
Message-ID: <20050525161247.GH23621@csclub.uwaterloo.ca>
References: <1116891772.30513.6.camel@gaston> <42929F2F.8000101@opersys.com> <1116905090.4992.7.camel@gaston> <200505242131.46827.kwall@kurtwerks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505242131.46827.kwall@kurtwerks.com>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2005 at 09:31:46PM -0400, Kurt Wall wrote:
> I see the same thing here on a plain vanilla CD-ROM (pardon the 
> unsightly wrapping):
> 
> May 23 21:52:34 luther kernel: hdc: packet command error: status=0x51 
> { DriveReady SeekComplete Error }
> May 23 21:52:34 luther kernel: hdc: packet command error: error=0x54 
> { AbortedCommand LastFailedSense=0x05 }
> May 23 23:12:37 luther kernel: hdc: packet command error: status=0x51 
> { DriveReady SeekComplete Error }
> May 23 23:12:37 luther kernel: hdc: packet command error: error=0x54 
> { AbortedCommand LastFailedSense=0x05 }

Looks a lot like the MultiMode problem that the kernel has an option for
dealing with.  I remember needing that on a 440BX based system in the
past (and the Dell GX1 is such a system too).

Len Sorensen
