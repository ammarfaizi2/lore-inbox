Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129281AbRB1UcJ>; Wed, 28 Feb 2001 15:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129282AbRB1Ub7>; Wed, 28 Feb 2001 15:31:59 -0500
Received: from e166066.upc-e.chello.nl ([213.93.166.66]:61451 "EHLO Ion.var.cx")
	by vger.kernel.org with ESMTP id <S129281AbRB1Ubw>;
	Wed, 28 Feb 2001 15:31:52 -0500
Date: Wed, 28 Feb 2001 21:31:46 +0100
From: Frank v Waveren <fvw@var.cx>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Boris Dragovic <lynx@falcon.etf.bg.ac.yu>, linux-kernel@vger.kernel.org
Subject: Re: negative mod use count
Message-ID: <20010228213146.A1120@var.cx>
In-Reply-To: <200102281958.UAA13226@falcon.etf.bg.ac.yu> <3A9D5AAB.E9AB4673@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A9D5AAB.E9AB4673@didntduck.org>; from bgerst@didntduck.org on Wed, Feb 28, 2001 at 03:08:11PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2001 at 03:08:11PM -0500, Brian Gerst wrote:
> > what does negative module use count mean?
> A bugged module.

Not at all. A non-zero usage count means the module can't be unloaded.
Whatever the module does with the usage count apart from that is
completely it's own choice.

-- 
Frank v Waveren                                      Fingerprint: 0EDB 8787
fvw@[var.cx|dse.nl|stack.nl|chello.nl] ICQ#10074100     09B9 6EF5 6425 B855
Public key: http://www.var.cx/pubkey/fvw@var.cx-gpg     7179 3036 E136 B85D

