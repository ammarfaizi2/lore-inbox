Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129261AbRBLJzM>; Mon, 12 Feb 2001 04:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129363AbRBLJzC>; Mon, 12 Feb 2001 04:55:02 -0500
Received: from [212.117.90.2] ([212.117.90.2]:9735 "EHLO anduin.gondor.com")
	by vger.kernel.org with ESMTP id <S129261AbRBLJyw>;
	Mon, 12 Feb 2001 04:54:52 -0500
Date: Mon, 12 Feb 2001 10:54:45 +0100
From: Jan Niehusmann <jan@gondor.com>
To: "Ph. Marek" <marek@mail.bmlv.gv.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.[01] and duron - unresolved symbol _mmx_memcpy
Message-ID: <20010212105445.A879@gondor.com>
In-Reply-To: <3.0.6.32.20010212080459.0090ce80@pop3.bmlv.gv.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3.0.6.32.20010212080459.0090ce80@pop3.bmlv.gv.at>; from marek@mail.bmlv.gv.at on Mon, Feb 12, 2001 at 08:04:59AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2001 at 08:04:59AM +0100, Ph. Marek wrote:
> The offending function is _mmx_memcpy, which can be found in the System.map
> (but, opposed to other functions, with an upper "T" instead of "t").

I had the same problem after I accidentally compiled the kernel with
SMP support. make mrproper did help. (safe your .config before trying it)

Jan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
