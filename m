Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285754AbRLHCGL>; Fri, 7 Dec 2001 21:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285751AbRLHCGD>; Fri, 7 Dec 2001 21:06:03 -0500
Received: from sm13.texas.rr.com ([24.93.35.40]:60331 "EHLO sm13.texas.rr.com")
	by vger.kernel.org with ESMTP id <S285755AbRLHCFt>;
	Fri, 7 Dec 2001 21:05:49 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marvin Justice <mjustice@austin.rr.com>
Reply-To: mjustice@austin.rr.com
To: Jens Axboe <axboe@suse.de>
Subject: Re: highmem question
Date: Fri, 7 Dec 2001 20:10:24 -0600
X-Mailer: KMail [version 1.2]
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0112071404280.29154-100000@mustard.heime.net> <01120719534703.00764@bozo> <20011208015446.GC32569@suse.de>
In-Reply-To: <20011208015446.GC32569@suse.de>
MIME-Version: 1.0
Message-Id: <01120720102404.00764@bozo>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> That's because of highmem page bouncing when doing I/O. There is indeed
> a solution for this -- 2.5 or 2.4 + block-highmem-all patches will
> happily do I/O directly to any page in your system as long as your
> hardware supports it. I'm sure we're beating w2k with that enabled :-)

Will your patch lead to better performance than the CONFIGH_HIGHMEM=n case? 
Unfortunately, W2K with any amount of memory beat Linux with no highmem (see 
http://www.uwsg.indiana.edu/hypermail/linux/kernel/0110.3/0375.html ) so my 
PHB decided to hold off on Linux for now.

Marvin
