Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310458AbSCRFFo>; Mon, 18 Mar 2002 00:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310483AbSCRFFf>; Mon, 18 Mar 2002 00:05:35 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:16126
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S310458AbSCRFFX>; Mon, 18 Mar 2002 00:05:23 -0500
Date: Sun, 17 Mar 2002 21:06:18 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: "David S. Miller" <davem@redhat.com>
Cc: alan@lxorguk.ukuu.org.uk, davids@webmaster.com,
        linux-kernel@vger.kernel.org
Subject: Re: RFC2385 (MD5 signature in TCP packets) support
Message-ID: <20020318050618.GC2254@matchmail.com>
Mail-Followup-To: "David S. Miller" <davem@redhat.com>,
	alan@lxorguk.ukuu.org.uk, davids@webmaster.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <E16m3Dt-0005Hr-00@the-village.bc.nu> <20020317.200949.32384373.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2002 at 08:09:49PM -0800, David S. Miller wrote:
>    From: Alan Cox <alan@lxorguk.ukuu.org.uk>
>    Date: Sat, 16 Mar 2002 01:43:05 +0000 (GMT)
>    
>    Dave's suggestion is netfilter - and netfilter is fast enough I
>    think. You only need filters on stuff you have already decided is
>    for your IP too.
> 
> After some thinking, the TAP idea is even nicer as it guarentees zero
> overhead, make it such that you only route the BGP stuff over the
> device having the TAP attached (make a dummy eth alias just for this
> purpose).
> 

... You'd have to use netfilter to mark the correct packets, then route on
that mark to the dummy interface.

How is that more efficient?
