Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288216AbSACGAj>; Thu, 3 Jan 2002 01:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288218AbSACGA3>; Thu, 3 Jan 2002 01:00:29 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:49541
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S288216AbSACGAY>; Thu, 3 Jan 2002 01:00:24 -0500
Date: Thu, 3 Jan 2002 00:46:04 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Dave Jones <davej@suse.de>, Lionel Bouton <Lionel.Bouton@free.fr>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: ISA slot detection on PCI systems?
Message-ID: <20020103004604.A3842@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Andrew Morton <akpm@zip.com.au>, Dave Jones <davej@suse.de>,
	Lionel Bouton <Lionel.Bouton@free.fr>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20020102211038.C21788@thyrsus.com> <Pine.LNX.4.33.0201030327501.5131-100000@Appserv.suse.de> <3C33EC64.8E505D54@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C33EC64.8E505D54@zip.com.au>; from akpm@zip.com.au on Wed, Jan 02, 2002 at 09:30:12PM -0800
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@zip.com.au>:
> If Eric can get the entire download-config-build-install process
> down to a single mouse click, he'll have done us all a great service.

Single-mouse-click configuration isn't going to happen soon.  It may 
not happen at all.

However, I believe pushing in that direction is worthwhile.
Configuration *can* be made a helluva lot easier than it is now.
Easier than I think most kernel developers would believe possible, at
least before sitting down to a serious think and abandoning a lot of
long-held assumptions about how things `have' to be.

CML2 was the first step.  It gives us a tool that can guarantee the
correctness and consistency of configuration changes according to a
rulebase.

The autoconfigurator that Giacomo Catenazzi started, which I am now
integrating with CML2, is the next step.  I expect it to reduce the
task complexity for typical configuration cases by 90%.  It's pretty
effective, including more than 2500 probes.

I don't know what the third step will be yet.  It depends partly on what
that remaining 10% looks like.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

"Experience should teach us to be most on our guard to protect liberty when the
government's purposes are beneficient...The greatest dangers to liberty lurk in
insidious encroachment by men of zeal, well meaning but without understanding."
	-- Supreme Court Justice Louis Brandeis
