Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130115AbRCER52>; Mon, 5 Mar 2001 12:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130111AbRCER5K>; Mon, 5 Mar 2001 12:57:10 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:50955 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S130105AbRCER46>;
	Mon, 5 Mar 2001 12:56:58 -0500
Date: Mon, 5 Mar 2001 18:56:46 +0100
From: Jens Axboe <axboe@suse.de>
To: LA Walsh <law@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Annoying CD-rom driver error messages
Message-ID: <20010305185646.K1992@suse.de>
In-Reply-To: <E14Zz5I-0007Pa-00@the-village.bc.nu> <3AA3D180.24661D6B@sgi.com> <3AA3D209.33A7F1CD@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3AA3D209.33A7F1CD@sgi.com>; from law@sgi.com on Mon, Mar 05, 2001 at 09:51:05AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05 2001, LA Walsh wrote:
> > > this isnt a kernel problem, its a _very_ stupid app
> > ---
> >         Must be more than one stupid app...
> > 
> > xena:/var/log# rpm -q magicdev
> > package magicdev is not installed
> > xena:/var/log# locate magicdev
> > xena:/var/log#
> > xena:/var/log# rpm -qa |grep -i magic
> > ImageMagick-5.2.6-4
> -------
> 
> Maybe the stupid app is 'freeamp'?  It only happens when I run it...:-(

Yep, it's a stupid app if it does CDROMSUBCHNL regardless of the
media type.

-- 
Jens Axboe

