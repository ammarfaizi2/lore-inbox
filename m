Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136820AbRECOlR>; Thu, 3 May 2001 10:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136821AbRECOlI>; Thu, 3 May 2001 10:41:08 -0400
Received: from 205-CORU-X5.libre.retevision.es ([62.83.56.205]:13736 "HELO
	trasno.mitica") by vger.kernel.org with SMTP id <S136820AbRECOky>;
	Thu, 3 May 2001 10:40:54 -0400
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, stoffel@casc.com (John Stoffel),
        esr@thyrsus.com, cate@dplanet.ch, linux-kernel@vger.kernel.org (CML2),
        kbuild-devel@lists.sourceforge.net
Subject: Re: Requirement of make oldconfig [was: Re: [kbuild-devel] Re: CML2 1.3.1, aka ...]
In-Reply-To: <200105031324.f43DOeaA030953@pincoya.inf.utfsm.cl>
X-Url: http://www.lfcia.org/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <200105031324.f43DOeaA030953@pincoya.inf.utfsm.cl>
Date: 03 May 2001 16:40:30 +0200
Message-ID: <m266fi7axt.fsf@trasno.mitica>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "horst" == Horst von Brand <vonbrand@inf.utfsm.cl> writes:

Hi

horst> Hell, I had to rebuild my .config files from scratch a few times already
horst> because of wild changes in the hardware on which the resulting kernels
horst> would have to run, its not _that_ big a deal to have to perhaps have to do
horst> it once each time a new stable kernel series starts or so.

Not a option.  You can have to had _several_ configurations around
(here at MandrakeSoft we have normal/smp/enterprise) and we have
basically everything that can be compiled as modules compiled as
modules.  Add to that that we build the alpha (normal&smp) from the
same package.  We want to add more architectures to the rpm.  Are you
really serious that _answering_ all the options for several kernels is
an option?  I don't think so.  And the actual olconfig target works
well for me (tm).  I don't see the point to rewrote the configuration
language and made it _less_ powerfull for no good reason.

Later, Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
