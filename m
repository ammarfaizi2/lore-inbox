Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262791AbTKJNiH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 08:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263484AbTKJNiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 08:38:07 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:464 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262791AbTKJNiD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 08:38:03 -0500
Date: Mon, 10 Nov 2003 14:37:46 +0100
From: Jens Axboe <axboe@suse.de>
To: P@draigBrady.com
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cfq + io priorities
Message-ID: <20031110133746.GB32637@suse.de>
References: <E1AJ994-0002xM-00@gondolin.me.apana.org.au> <1068469674.734.80.camel@cube> <3FAF9335.9010801@draigBrady.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FAF9335.9010801@draigBrady.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 10 2003, P@draigBrady.com wrote:
> Albert Cahalan wrote:
> >Besides, the kernel load average was changed to
> >include processes waiting for IO. It just plain
> >makes sense to mix CPU usage with IO usage by
> >default. Wanting different niceness for CPU
> >and IO is a really unusual thing.
> 
> I strongly agree. Of course it would be
> nice/necessary to have seperate nice values,
> but setting the global one should set the
> underlying ones (cpu, disk, ...) also.

Global one? nice is CPU in Linux, period. ionice is io priority. I'm not
going to change this. So Albert and you can agree as much as you want,
unless you have some heavier arguments it's not going to help one bit.

-- 
Jens Axboe

