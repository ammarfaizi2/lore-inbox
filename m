Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262192AbTKRNIk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 08:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262564AbTKRNIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 08:08:40 -0500
Received: from gprs147-139.eurotel.cz ([160.218.147.139]:2432 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262192AbTKRNIj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 08:08:39 -0500
Date: Tue, 18 Nov 2003 10:27:10 +0100
From: Pavel Machek <pavel@suse.cz>
To: Albert Cahalan <albert@users.sf.net>
Cc: Jens Axboe <axboe@suse.de>, P@draigBrady.com,
       Albert Cahalan <albert@users.sourceforge.net>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cfq + io priorities
Message-ID: <20031118092710.GA203@elf.ucw.cz>
References: <E1AJ994-0002xM-00@gondolin.me.apana.org.au> <1068469674.734.80.camel@cube> <3FAF9335.9010801@draigBrady.com> <20031110133746.GB32637@suse.de> <1068508372.734.116.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1068508372.734.116.camel@cube>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I suppose the nice() wrapper in glibc could
> be modified... but that's kind of silly when
> the kernel is getting modified anyway.

Perhaps modifying glibc is the right way after all. We do not want to
have nice(), ionice() and then cpunice() as a kernel interface.

OTOH it would be good to keep ionice() on the same scale as other
"nice" values so that "do-it-all" interface is easier.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
