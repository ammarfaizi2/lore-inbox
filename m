Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263285AbTCNIBq>; Fri, 14 Mar 2003 03:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263286AbTCNIBq>; Fri, 14 Mar 2003 03:01:46 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:24121
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S263285AbTCNIBp>; Fri, 14 Mar 2003 03:01:45 -0500
Date: Fri, 14 Mar 2003 03:08:53 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Oleg Drokin <green@namesys.com>
cc: Jens Axboe <axboe@suse.de>, Oleg Drokin <green@linuxhacker.ru>,
       "" <alan@redhat.com>, "" <linux-kernel@vger.kernel.org>,
       "" <viro@math.psu.edu>
Subject: Re: [2.4] init/do_mounts.c::rd_load_image() memleak
In-Reply-To: <20030314110421.A28273@namesys.com>
Message-ID: <Pine.LNX.4.50.0303140308110.17112-100000@montezuma.mastecende.com>
References: <20030313210144.GA3542@linuxhacker.ru> <20030313220308.A28040@flint.arm.linux.org.uk>
 <20030314105032.A17568@namesys.com> <20030314075957.GX836@suse.de>
 <20030314110421.A28273@namesys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Mar 2003, Oleg Drokin wrote:

> Well, my argument is code uniformness which was always valid as long as it does not
> introduce any bugs, I think.
> Do you propose somebody should go and fix all
> if ( something )
> 	kfree(something);
> pieces of code to read just
> kfree(something); ?

It's defined that kfree(NULL) is valid. I tried the above mentioned 
'cleanup' a while ago, way too noisy.

	Zwane
