Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288834AbSBDJmU>; Mon, 4 Feb 2002 04:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288830AbSBDJmL>; Mon, 4 Feb 2002 04:42:11 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:20744 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S288821AbSBDJmB>;
	Mon, 4 Feb 2002 04:42:01 -0500
Date: Mon, 4 Feb 2002 10:39:56 +0100
From: Jens Axboe <axboe@suse.de>
To: Gregor Jasny <gjasny@wh8.tu-dresden.de>
Cc: Erik Andersen <andersen@codepoet.org>,
        "Calin A. Culianu" <calin@ajvar.org>, linux-kernel@vger.kernel.org
Subject: Re: Asynchronous CDROM Events in Userland
Message-ID: <20020204103956.T29553@suse.de>
In-Reply-To: <Pine.LNX.4.30.0202032333200.1158-100000@rtlab.med.cornell.edu> <20020204070414.GA19268@codepoet.org> <20020204085712.O29553@suse.de> <200202040933.g149Xidx006940@backfire.WH8.TU-Dresden.De>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200202040933.g149Xidx006940@backfire.WH8.TU-Dresden.De>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04 2002, Gregor Jasny wrote:
> Am Montag, 4. Februar 2002 08:57 schrieb Jens Axboe:
> > Yep, _no_ drives to date support queued event notification. However, a
> > polled approach is really not too bad -- it simply means that we'll push
> > it to user space instead. I've written a small utility for reference.
> 
> You're wrong.

Not likely

> PLEXTOR CD-R PX-W2410A
> media removal
> eject request
> media removal
> media removal
> 
> HITACHI DVD-ROM GD-2500
> no media change
> new media
> media removal

I'm wrong about what? If you mean that my test app works, then yes of
course it works. It's a synchronous command poll for media status. I
said that _queued event notification_ isn't implemented in any drives.

Did you read the code?

-- 
Jens Axboe

