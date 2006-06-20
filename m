Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965061AbWFTIsD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965061AbWFTIsD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 04:48:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965215AbWFTIsB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 04:48:01 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:9918 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S965061AbWFTIsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 04:48:01 -0400
Date: Tue, 20 Jun 2006 10:47:59 +0200
From: Andreas Mohr <andim2@users.sourceforge.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, hal@lists.freedesktop.org, gregkh@suse.de,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: USB/hal: USB open() broken? (USB CD burner underruns, USB HDD hard resets)
Message-ID: <20060620084759.GA798@rhlx01.fht-esslingen.de>
Reply-To: andi@lisas.de
References: <20060619082154.GA17129@rhlx01.fht-esslingen.de> <20060620013741.8e0e4a22.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060620013741.8e0e4a22.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 20, 2006 at 01:37:41AM -0700, Andrew Morton wrote:
> On Mon, 19 Jun 2006 10:21:54 +0200
> Andreas Mohr <andi@rhlx01.fht-esslingen.de> wrote:
> 
> > I'm having severe issues with cdrecord aborting with "buffer underrun"
> > message, *always*. Problem nailed, see below.
> 
> [hald polling causes cdrecord to go bad on a USB CD drive]
> 
> One possible reason is that we're shooting down the device's pagecache by
> accident as a result of hald activity.  This shouldn't happen, but still.
> Could you please do

[...]

Thanks, will do.

Just filed this as
http://bugzilla.kernel.org/show_bug.cgi?id=6722
due to no response here before.

(#6194 looks like it might be the same issue)

I'd suggest continuing discussion at bug #6722 from now.

Thanks,

Andreas Mohr

-- 
No programming skills!? Why not help translate many Linux applications! 
https://launchpad.ubuntu.com/rosetta
(or alternatively buy nicely packaged Linux distros/OSS software to help
support Linux developers creating shiny new things for you?)
