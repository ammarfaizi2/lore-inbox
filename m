Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271020AbTGPRot (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 13:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271018AbTGPRnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 13:43:46 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:11975 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S270965AbTGPRms (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 13:42:48 -0400
Date: Wed, 16 Jul 2003 19:57:41 +0200
From: Jens Axboe <axboe@suse.de>
To: Dave Jones <davej@codemonkey.org.uk>, Valdis.Kletnieks@vt.edu,
       vojtech@suse.cz, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PS2 mouse going nuts during cdparanoia session.
Message-ID: <20030716175741.GR833@suse.de>
References: <20030716165701.GA21896@suse.de> <20030716170352.GJ833@suse.de> <200307161710.h6GHAsU1001493@turing-police.cc.vt.edu> <20030716171706.GN833@suse.de> <20030716175534.GA25712@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030716175534.GA25712@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16 2003, Dave Jones wrote:
> On Wed, Jul 16, 2003 at 07:17:06PM +0200, Jens Axboe wrote:
>  > > Dumb user question - which rippers support SG_IO?  I've been using
>  > > cdparanoia mostly for lack of a good reason to migrate - but this
>  > > sounds like a good reason. ;)
>  > 
>  > Not a dumb question at all, see my previous mail :). In short, I don't
>  > know. I'm sure a little collective effort could hunt some down (cdda2wav
>  > should work, since it uses libscg presumable).
> 
> For info, I just tried cdda2wav, and whilst it used less CPU than
> cdparanoia, the dancing mouse effect still occurs 8-(

Can you check whether it uses SG_IO ioctl (0x2285) or read/write on
/dev/sg*?  Strace please :)

-- 
Jens Axboe

