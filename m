Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267038AbSLKHOG>; Wed, 11 Dec 2002 02:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267041AbSLKHOG>; Wed, 11 Dec 2002 02:14:06 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:7843 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S267038AbSLKHOF>;
	Wed, 11 Dec 2002 02:14:05 -0500
Date: Wed, 11 Dec 2002 08:21:39 +0100
From: Jens Axboe <axboe@suse.de>
To: Wil Reichert <wilreichert@yahoo.com>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: "bio too big" error
Message-ID: <20021211072139.GF16003@suse.de>
References: <1039572597.459.82.camel@darwin> <3DF6A673.D406BC7F@digeo.com> <1039577938.388.9.camel@darwin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1039577938.388.9.camel@darwin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10 2002, Wil Reichert wrote:
> Exact error with debug is:
> 
> darwin:/a01/mp3s/Skinny Puppy/Too Dark Park# ogg123 -q 01\ -\
> Convulsion.ogg
> bio too big device ide0(3,4) (256 > 255)

looks like a one-off in the dm merge_bvec function.

-- 
Jens Axboe

