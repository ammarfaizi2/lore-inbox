Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130333AbQKLJfi>; Sun, 12 Nov 2000 04:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130352AbQKLJf2>; Sun, 12 Nov 2000 04:35:28 -0500
Received: from Cantor.suse.de ([194.112.123.193]:25874 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S130333AbQKLJfV>;
	Sun, 12 Nov 2000 04:35:21 -0500
Date: Sun, 12 Nov 2000 10:35:19 +0100
From: Andi Kleen <ak@suse.de>
To: "H. Peter Anvin" <hpa@transmeta.com>
Cc: Peter Samuelson <peter@cadcamlab.org>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Where is it written?
Message-ID: <20001112103519.A7325@gruyere.muc.suse.de>
In-Reply-To: <20001110184031.A2704@munchkin.spectacle-pond.org> <20001110192751.A2766@munchkin.spectacle-pond.org> <20001111163204.B6367@inspiron.suse.de> <20001111171749.A32100@wire.cadcamlab.org> <8ukkr3$f2h$1@cesium.transmeta.com> <20001111225428.A20749@wire.cadcamlab.org> <3A0E28BD.CCA5D85F@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A0E28BD.CCA5D85F@transmeta.com>; from hpa@transmeta.com on Sat, Nov 11, 2000 at 09:21:01PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2000 at 09:21:01PM -0800, H. Peter Anvin wrote:
> 
> We tried once; at that point the register-based ABI support in gcc was
> too buggy to be useful.  We might try again in 2.5 since we now have
> increased the minimum gcc version for kernel compiles.  Binutils needs no
> change.

As far as I know egcs 1.1 still has fastcall bugs, they were only fixed in
2.95 (which unfortunately has other bugs). So to use it the minimum compiler 
would need to be bumped again.


-Andi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
