Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131535AbQKZOoR>; Sun, 26 Nov 2000 09:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131537AbQKZOoI>; Sun, 26 Nov 2000 09:44:08 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34826 "EHLO
        www.linux.org.uk") by vger.kernel.org with ESMTP id <S131535AbQKZOn7>;
        Sun, 26 Nov 2000 09:43:59 -0500
Date: Sun, 26 Nov 2000 14:13:44 +0000
From: Philipp Rumpf <prumpf@parcelfarce.linux.theplanet.co.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: georgn@home.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0"
Message-ID: <20001126141344.T2272@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <14880.29022.261932.284497@somanetworks.com> <E13ztNR-0001ew-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <E13ztNR-0001ew-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, Nov 26, 2000 at 04:25:05AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2000 at 04:25:05AM +0000, Alan Cox wrote:
> 	static int a=0;
> 
> says 'I thought about this. I want it to start at zero. I've written it this
> way to remind of the fact'
> 
> Sure it generates the same code

I agree it would be best if gcc would generate the same code;  unfortunately
this doesn't seem to be the case, which sounds like something to take up with
the gcc developers.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
