Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129932AbQK2JAZ>; Wed, 29 Nov 2000 04:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129933AbQK2JAP>; Wed, 29 Nov 2000 04:00:15 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:54361 "EHLO
        twilight.cs.hut.fi") by vger.kernel.org with ESMTP
        id <S129932AbQK2JAB>; Wed, 29 Nov 2000 04:00:01 -0500
Date: Wed, 29 Nov 2000 10:29:15 +0200
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18pre19 oops in try_to_free_pages
Message-ID: <20001129102915.S53529@niksula.cs.hut.fi>
In-Reply-To: <20001128134418.C54301@niksula.cs.hut.fi> <20001129013801.A20971@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001129013801.A20971@athlon.random>; from andrea@suse.de on Wed, Nov 29, 2000 at 01:38:01AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2000 at 01:38:01AM +0100, you [Andrea Arcangeli] claimed:
> On Tue, Nov 28, 2000 at 01:44:18PM +0200, Ville Herva wrote:
> > try Andrea's vm-global-7 now. It seems to include the bits Rik posted, or
> 
> It doesn't include the bits Rik posted because they were unnecessary.

Ummh. What am I smoking?

% patch -p1 --dry-run < ../riel-vm.patch
patching file mm/vmscan.c
Reversed (or previously applied) patch detected!  Assume -R? [n]
Apply anyway? [n]
Skipping patch.
7 out of 7 hunks ignored -- saving rejects to file mm/vmscan.c.rej

I was sure that I only applied vm-global-7 on top of 2.2.18pre19 before
that. Perhaps I have applied Rik's patch on some morning before waking up,
but...


-- v --

v@iki.fi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
