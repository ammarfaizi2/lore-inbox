Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133048AbRDRHao>; Wed, 18 Apr 2001 03:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133051AbRDRHae>; Wed, 18 Apr 2001 03:30:34 -0400
Received: from ns.caldera.de ([212.34.180.1]:44562 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S133048AbRDRHaZ>;
	Wed, 18 Apr 2001 03:30:25 -0400
Date: Wed, 18 Apr 2001 09:28:47 +0200
From: Christoph Hellwig <hch@ns.caldera.de>
To: "Eric S. Raymond" <esr@snark.thyrsus.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@transmeta.com,
        axel@uni-paderborn.de, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Supplying missing entries for Configure.help, part 2
Message-ID: <20010418092847.A15790@caldera.de>
Mail-Followup-To: "Eric S. Raymond" <esr@snark.thyrsus.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@transmeta.com,
	axel@uni-paderborn.de, linux-kernel@vger.kernel.org,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <200104180054.f3I0sne02402@snark.thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <200104180054.f3I0sne02402@snark.thyrsus.com>; from esr@snark.thyrsus.com on Tue, Apr 17, 2001 at 08:54:49PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2001 at 08:54:49PM -0400, Eric S. Raymond wrote:
> +Kernel support for JAVA binaries
> +CONFIG_BINFMT_JAVA
> +  If you answer Y here, the kernel's program loader will know how to
> +  directly execute Java J-code.  This option is semi-obsolescent; you 
> +  should probably use CONFIG_BINFMT_MISC and read Documentation/java.txt
> +  for information about how to include Java support.
> +

binmft_java is gone - the relvant CONFIG_ option should be removed instead
of getting a help entry...

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
