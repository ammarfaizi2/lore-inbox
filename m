Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285338AbSAGTRa>; Mon, 7 Jan 2002 14:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285327AbSAGTRU>; Mon, 7 Jan 2002 14:17:20 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:61452 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S285338AbSAGTRC>;
	Mon, 7 Jan 2002 14:17:02 -0500
Date: Sat, 5 Jan 2002 13:38:01 +0000
From: Pavel Machek <pavel@suse.cz>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFT] simple deadline I/O scheduler
Message-ID: <20020105133800.A37@toy.ucw.cz>
In-Reply-To: <20020104094334.N8673@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20020104094334.N8673@suse.de>; from axboe@suse.de on Fri, Jan 04, 2002 at 09:43:34AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I've played around with implementing an I/O scheduler that _tries_ to
> start request within a given time limit. Note that it makes no
> guarentees of any sort, it's simply a "how does this work in real life"
> sort of thing. It's main use is actually to properly extend the i/o
> scheduler / elevator api to be able to implement more advanced
> schedulers (eg cello).

Would it be possible to introduce concept of I/O priority? I.e. I want 
updatedb not to load disk if I need it for something else?

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

