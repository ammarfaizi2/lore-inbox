Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292330AbSBPJZm>; Sat, 16 Feb 2002 04:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292331AbSBPJZd>; Sat, 16 Feb 2002 04:25:33 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:9978 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S292330AbSBPJZU>; Sat, 16 Feb 2002 04:25:20 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20020216013538.A23546@thyrsus.com> 
In-Reply-To: <20020216013538.A23546@thyrsus.com>  <20020215135557.B10961@thyrsus.com> <20020215224916.L27880@suse.de> <20020215170459.A15406@thyrsus.com> <20020215232517.FXLQ71.femail38.sdc1.sfba.home.com@there> 
To: esr@thyrsus.com
Cc: Rob Landley <landley@trommello.org>, Dave Jones <davej@suse.de>,
        Larry McVoy <lm@work.bitmover.com>,
        Arjan van de Ven <arjan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Disgusted with kbuild developers 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 16 Feb 2002 09:21:19 +0000
Message-ID: <22614.1013851279@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


esr@thyrsus.com said:
>  The big problem isn't the code transition.  It's the rulebase
> transition.

Only because you make it so.

I have no objection to the CML2 language and tools.

I've never done much more than glance at the CML1 mechanism, and as long as 
"$EDITOR .config && make oldconfig" continues to work as expected I doubt 
I'd ever pay any more attention to CML2. 

I am aware that CML2 should allow me to more accurately represent some
things that CML1 couldn't, and I would welcome that.

However - the thing to which I and many others object most strongly is the 
rulebase policy changes which appear to be inseparable from the change in 
mechanism. That is; we've tried to get you to separate them, and failed.

As you keep saying, CML1 is a very limited language. If CML2 cannot even
represent the _existing_ CML1 ruleset, then I think you need to go back to
the drawing board. 

I, for one, will have no objection to a merge of CML2 with an automated 
translation of the CML1 rules. You can 'improve' the rulebase later, at 
which point each change you want to make can be given individual attention.

You've said before that an automated translation is impossible. That's not 
our problem - it's yours. Fix the CML2 language so it _is_ possible. If that 
means adding ugly hacks to make it work, so be it - do it in the 
expectation that you can fix the rulebase later and remove them again.

Eric, you have demonstrated repeatedly that your taste w.r.t the
configuration rules is extremely, erm, 'different' from that of the majority
of developers. I find it difficult to believe that a self-proclaimed
'hacker of social systems' cannot comprehend the need to strictly separate
the mechanism changes from the controversial rulebase changes.

--
dwmw2


