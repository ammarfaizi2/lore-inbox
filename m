Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130300AbQK2Bm3>; Tue, 28 Nov 2000 20:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130773AbQK2BmJ>; Tue, 28 Nov 2000 20:42:09 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:27151 "EHLO virtualhost.dk")
        by vger.kernel.org with ESMTP id <S130300AbQK2Bl6>;
        Tue, 28 Nov 2000 20:41:58 -0500
Date: Wed, 29 Nov 2000 02:11:50 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>, "David S. Miller" <davem@redhat.com>,
        viro@math.psu.edu, linux-kernel@vger.kernel.org, tytso@valinux.com
Subject: Re: 2.4.0-test11 ext2 fs corruption
Message-ID: <20001129021150.A24264@suse.de>
In-Reply-To: <E2C40AB5D29@vcnet.vc.cvut.cz> <20001129014329.C23771@suse.de> <20001129020852.C20971@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001129020852.C20971@athlon.random>; from andrea@suse.de on Wed, Nov 29, 2000 at 02:08:52AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29 2000, Andrea Arcangeli wrote:
> Side note: that could generate mem/io corruption only on headactive devices
> (like IDE).

Yep, that's why I told Linus it was a long shot and couldn't possibly
account for all the corruption cases reported. And one would expect
fs corruption to go with that as well. So it's of course a long shot,
but still worth trying for Petr.

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
