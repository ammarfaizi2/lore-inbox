Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313455AbSDLIm2>; Fri, 12 Apr 2002 04:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313459AbSDLIm1>; Fri, 12 Apr 2002 04:42:27 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:48910 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S313455AbSDLIm1>;
	Fri, 12 Apr 2002 04:42:27 -0400
Date: Fri, 12 Apr 2002 10:41:50 +0200
From: Jens Axboe <axboe@suse.de>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: vojtech@suse.cz, martin@dalecki.de, linux-kernel@vger.kernel.org
Subject: Re: VIA, 32bit PIO and 2.5.x kernel
Message-ID: <20020412084150.GE824@suse.de>
In-Reply-To: <20020412001029.GA1172@ppc.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12 2002, Petr Vandrovec wrote:
> I believe that there must be some reason for doing that... And 
> do not ask me why it worked in 2.4.x, as it cleared io_32bit
> in task_out_intr too.

Because 2.4 doesn't use that path for fs requests. And be glad that it
doesn't otherwise _everybody_ would have much worse problems than you
are currently seeing.

-- 
Jens Axboe

