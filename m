Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292353AbSBPLYI>; Sat, 16 Feb 2002 06:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292354AbSBPLX6>; Sat, 16 Feb 2002 06:23:58 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:47367 "EHLO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S292353AbSBPLXk>; Sat, 16 Feb 2002 06:23:40 -0500
Date: Sat, 16 Feb 2002 12:23:35 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Disgusted with kbuild developers
Message-ID: <20020216112334.GA2805@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020215135557.B10961@thyrsus.com> <200202151929.g1FJTaU03362@pc1-camc5-0-cust78.cam.cable.ntl.com> <20020215141433.B11369@thyrsus.com> <20020215195818.A3534@pc1-camc5-0-cust78.cam.cable.ntl.com> <20020215145421.A12540@thyrsus.com> <20020215213833.J27880@suse.de> <1013810923.807.1055.camel@phantasy> <20020215232832.N27880@suse.de> <3C6DE87C.FA96D1D6@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C6DE87C.FA96D1D6@mandrakesoft.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Feb 2002, Jeff Garzik wrote:

> Dave Jones wrote:
> >  Increased functionality I don't have a problem with, as long
> >  as other more important things are addressed.  And for that matter,
> >  Linus has said to Eric "I don't care, take this out of the
> >  kernel completely leaving just oldconfig'.
> 
> That's a good point, and one I would be happy with.  (or, ditch -all-
> current config code, and replace with the existing mconfig)

If so, then fairness of mconfig vs. CML2 tools should command that
mconfig's "old" mode works properly first. I reported to Christoph that
it always reprompts me about the kernel core format (a.out vs. ELF),
which is something "make oldconfig" does not do with the same config, he
acknowledged the bug, but I have yet to see the fix.

> Eric's configurator definitely seems to have a place with users.  Making
> kernel configuration easier for the masses is more than fine with me... 
> Impacting kernel developers' productivity and workflow because of this
> is more of what I object to...

Does that really happen? It looks as though the conversion of the
current config.in stuff has been completed as part of the CML2 suite.
