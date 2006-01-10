Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932599AbWAJU3e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932599AbWAJU3e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 15:29:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932596AbWAJU3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 15:29:34 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:46256 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S932599AbWAJU3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 15:29:32 -0500
Date: Tue, 10 Jan 2006 15:29:20 -0500
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Andi Kleen <ak@suse.de>, Dave Jones <davej@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Console debugging wishlist was: Re: oops pauser.
Message-ID: <20060110202920.GA5479@filer.fsl.cs.sunysb.edu>
References: <20060105045212.GA15789@redhat.com> <p73vewtw8bh.fsf@verdi.suse.de> <Pine.LNX.4.61.0601102121400.16049@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0601102121400.16049@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2006 at 09:25:46PM +0100, Jan Engelhardt wrote:
> >What would be also cool would be to fix the VGA console to have 
> >a larger scroll back buffer.  The standard kernel boot output 
> >is far larger than the default scrollback, so if you get a hang
> >late you have no way to look back to all the earlier 
> >messages.
> >
> >(it is hard to understand that with 128MB+ graphic cards and 512+MB
> >computers the scroll back must be still so short...) 
> 
> I doubt this scrollback buffer is implemented as part of the video cards. 
> It is rather a kernel invention, and therefore uses standard RAM. But the 
> idea is good, preferably make it a CONFIG_ option.

There is a config option that lets you specify the size of this buffer:
CONFIG_LOG_BUF_SHIFT

Jeff.
