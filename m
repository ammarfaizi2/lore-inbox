Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281805AbRLGOzD>; Fri, 7 Dec 2001 09:55:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281795AbRLGOyy>; Fri, 7 Dec 2001 09:54:54 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:65285 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S281780AbRLGOyj>;
	Fri, 7 Dec 2001 09:54:39 -0500
Date: Fri, 7 Dec 2001 15:54:31 +0100
From: Jens Axboe <axboe@suse.de>
To: rwhron@earthlink.net
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: Oops on 2.5.1-pre6 doing mkreiserfs on loop device
Message-ID: <20011207145431.GI12017@suse.de>
In-Reply-To: <20011206233759.A173@earthlink.net> <20011207144836.GF12017@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011207144836.GF12017@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07 2001, Jens Axboe wrote:
> +	bio_for_each_segment(bvec, bio, i) {
> +		org_vec = &bio_orig->bi_io_vec[0];
                                               ^

argh, that should read 'i' and not '0' of course.

-- 
Jens Axboe

