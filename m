Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284987AbSBBX6t>; Sat, 2 Feb 2002 18:58:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284300AbSBBX6i>; Sat, 2 Feb 2002 18:58:38 -0500
Received: from brick.kernel.dk ([195.249.94.204]:23961 "EHLO
	burns.home.kernel.dk") by vger.kernel.org with ESMTP
	id <S284305AbSBBX6b>; Sat, 2 Feb 2002 18:58:31 -0500
Date: Sun, 3 Feb 2002 00:58:19 +0100
From: Jens Axboe <axboe@suse.de>
To: Andre Hedrick <andre@linuxdiskcert.org>
Cc: "Axel H. Siebenwirth" <axel@hh59.org>,
        Anton Altaparmakov <aia21@cam.ac.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.3 - (IDE) hda: drive not ready for command errors
Message-ID: <20020203005819.C29553@suse.de>
In-Reply-To: <20020202102659.L12156@suse.de> <Pine.LNX.4.10.10202021158010.26613-100000@master.linux-ide.org> <20020203002821.A29553@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020203002821.A29553@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 03 2002, Jens Axboe wrote:
> > what we are trying to get away from but we really need a way to stream the
> > pointers to the data register cleanly.  Otherwise the benefits of the zero
> > copy in block go away.
> 
> ?? Your point is not clear. zero copy what, request struct?! That would
> be way below measurable.

Sorry, I see what you mean, was a bit too quick. To me the current code
looks ok in this regard, I don't see any problems with that. If you have
noticed a problem please out line it and I'll take a look tomorrow. Now,
bed time.

-- 
Jens Axboe

