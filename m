Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291014AbSAaTBa>; Thu, 31 Jan 2002 14:01:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291235AbSAaTBU>; Thu, 31 Jan 2002 14:01:20 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:19332 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S291014AbSAaTBI>;
	Thu, 31 Jan 2002 14:01:08 -0500
Date: Thu, 31 Jan 2002 14:01:06 -0500
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Larry McVoy <lm@work.bitmover.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        lm@bitmover.com
Subject: Re: real BK usage (was: A modest proposal -- We need a patch penguin)
Message-ID: <20020131140106.C669@havoc.gtf.org>
In-Reply-To: <Pine.LNX.4.33.0201291641090.1747-100000@penguin.transmeta.com> <1012354692.1777.4.camel@stomata.megapathdsl.net> <20020130080504.JUTO18525.femail19.sdc1.sfba.home.com@there> <20020130034746.K32317@havoc.gtf.org> <a38ekv$1is$1@penguin.transmeta.com> <20020130050708.D11267@havoc.gtf.org> <20020130102458.B763@lynx.adilger.int> <20020130093459.P23269@work.bitmover.com> <20020130130319.G763@lynx.adilger.int> <20020131091110.K1519@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020131091110.K1519@work.bitmover.com>; from lm@bitmover.com on Thu, Jan 31, 2002 at 09:11:10AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2002 at 09:11:10AM -0800, Larry McVoy wrote:
> This thread has been about the idea of being able to send any one of those
> changes out in isolation, right?  That's the problem we are solving.  But
> your statement is that you want to test them all at once, testing them one
> at a time is too much work.

Maybe, maybe not.  When hacking on filesystems I try to produce
"viro-style" patches, which are a series of patches, each containing
a single transformation.  Each one is tested in isolation in addition to
the final product.  Extremely useful for nipping problems in the bud
sooner rather than later.

	Jeff



