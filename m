Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131375AbRANJcx>; Sun, 14 Jan 2001 04:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131397AbRANJcn>; Sun, 14 Jan 2001 04:32:43 -0500
Received: from kamov.deltanet.ro ([193.226.175.3]:50705 "HELO
	kamov.deltanet.ro") by vger.kernel.org with SMTP id <S131375AbRANJcj>;
	Sun, 14 Jan 2001 04:32:39 -0500
Date: Sun, 14 Jan 2001 11:32:27 +0200
From: Petru Paler <ppetru@ppetru.net>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sparc64 compile fix
Message-ID: <20010114113227.A1394@ppetru.net>
In-Reply-To: <20010113152104.B2734@ppetru.net> <14944.56558.198555.536993@pizda.ninka.net> <20010114010125.M2734@ppetru.net> <14945.28453.291879.887740@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.13i
In-Reply-To: <14945.28453.291879.887740@pizda.ninka.net>; from davem@redhat.com on Sun, Jan 14, 2001 at 01:19:33AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 14, 2001 at 01:19:33AM -0800, David S. Miller wrote:
> Petru Paler writes:
>  > Trying to compile 2.4.0-ac8 resulted in an error about
>  > storage size of variable d not being known (I don't have the
>  > exact error at hand, the network connectivity to that server
>  > is down right now). Changing it to dqblk32 got it to compile.
>  > 
>  > Am I doing something else wrong ?
> 
> If the quota interfaces have changed, then all of the translation code
> support for them in sys_sparc32.c/systbls.S/etc. need to change to
> accomodate.
> 
> Stick with non-AC kernels for no on sparc64, thanks. (But feel free to
> use the zerocopy patches :-)

Ok :)

Actually I'm just looking for a kernel to run fast & smoothly on those servers...
Will give 2.4.0-pre3 + zerocopy a try.

--
Petru Paler, mailto:ppetru@ppetru.net
http://www.ppetru.net - ICQ: 41817235
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
