Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131983AbQKBBJn>; Wed, 1 Nov 2000 20:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132018AbQKBBJe>; Wed, 1 Nov 2000 20:09:34 -0500
Received: from napalm.go.cz ([212.24.148.98]:5636 "EHLO napalm.go.cz")
	by vger.kernel.org with ESMTP id <S131983AbQKBBJR>;
	Wed, 1 Nov 2000 20:09:17 -0500
Date: Thu, 2 Nov 2000 02:08:46 +0100
From: Jan Dvorak <johnydog@go.cz>
To: George <greerga@entropy.muc.muohio.edu>
Cc: Kurt Garloff <garloff@suse.de>, "J . A . Magallon" <jamagallon@able.es>,
        Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Where did kgcc go in 2.4.0-test10 ?
Message-ID: <20001102020846.A335@napalm.go.cz>
Mail-Followup-To: George <greerga@entropy.muc.muohio.edu>,
	Kurt Garloff <garloff@suse.de>,
	"J . A . Magallon" <jamagallon@able.es>,
	Linux kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20001101235734.D10585@garloff.etpnet.phys.tue.nl> <Pine.LNX.4.21.0011011802500.14734-100000@entropy.muc.muohio.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0011011802500.14734-100000@entropy.muc.muohio.edu>; from greerga@entropy.muc.muohio.edu on Wed, Nov 01, 2000 at 06:04:38PM -0500
Organization: (XNET.cz)
X-URL: http://doga.go.cz/
X-OS: Linux 2.2.17 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2000 at 06:04:38PM -0500, George wrote:
> On Wed, 1 Nov 2000, Kurt Garloff wrote:
> >kgcc is a redhat'ism. They invented this package because their 2.96 fails
> >compiling a stable kernel. However, it's not a good idea to dist specific
> >code into the official kernel tree.
> 
> Big picture.
> 
> It may be distribution specific right now, but that doesn't stop other
> distributions from needing it later.

If number of distribution kernel-independent-compilers increase (and it
will, at least until gcc 2.97/3.0 branch stabilize), it will be better to
put in kernel variable (maybe in config) which cc to use. I agree, that this
is not the best thing to do - put such code in kernel, but if it'll be
needed, it can be done as shell script - 'which cc you want to compile
kernel ? (1) gcc (default) (2) kgcc .... (X) Other: ___'. 

Jan Dvorak <johnydog@go.cz>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
