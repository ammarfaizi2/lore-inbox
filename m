Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292414AbSBPQt5>; Sat, 16 Feb 2002 11:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292428AbSBPQtr>; Sat, 16 Feb 2002 11:49:47 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:43272
	"EHLO golux.thyrsus.com") by vger.kernel.org with ESMTP
	id <S292414AbSBPQtc>; Sat, 16 Feb 2002 11:49:32 -0500
Date: Sat, 16 Feb 2002 11:22:21 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dave Jones <davej@suse.de>, Robert Love <rml@tech9.net>,
        Arjan van de Ven <arjan@pc1-camc5-0-cust78.cam.cable.ntl.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Disgusted with kbuild developers
Message-ID: <20020216112221.A32311@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Jones <davej@suse.de>,
	Robert Love <rml@tech9.net>,
	Arjan van de Ven <arjan@pc1-camc5-0-cust78.cam.cable.ntl.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020216105425.A31986@thyrsus.com> <E16c7rR-0006Z5-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E16c7rR-0006Z5-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sat, Feb 16, 2002 at 04:38:53PM +0000
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk>:
> You can force a side effect in both directions. The language provides the
> information to do that, the current -toolset- can't handle this.
> 
> At any point you ask a question you can "wind back" and compute the set
> of changes that are needed and re-ask only the needed questions.

I spent over a month in early 2000 trying a similar approach.  I tried it
with CML1, and I tried it with increasingly enriched dialects of CML1
(magic comments carrying extra semantic information, that sort of thing).

The results were (a) ugly, and (b) broken.  I struggled against this
for a long time, because I knew what a horrible revolving bitch and
maintaining a parallel rulebase in a new formalism was going to be.

As you no doubt realize, the problem of deducing the forcing
information from CMl1 markup is efectively equivalent to the problem
of writing a mechanical CML1-to-CML2 translator.  So I have a
suggestion: if you want to prove that it's possible to extract all the
info for side-effect forcing from CML1, do it by writing such a
translator.

I believe you will fail, as I did and as Jeff Garzik implicitly predicted.
If you fail, the process will teach you what I had to learn the hard way 
two years back.  If you succeed, people who are whingeing about wanting
a bug-for-bug rulebase translation will get what they want.

Don't tell me to do it.  Been there, done that, have the battle scars.
If there were any way I could have avoided maintaining my own rulebase,
you better believe I'd have done it.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>
