Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288661AbSANS1m>; Mon, 14 Jan 2002 13:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288658AbSANS1d>; Mon, 14 Jan 2002 13:27:33 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:50309
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S288664AbSANS1S>; Mon, 14 Jan 2002 13:27:18 -0500
Date: Mon, 14 Jan 2002 13:10:50 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Mr. James W. Laferriere" <babydr@baby-dragons.com>,
        Giacomo Catenazzi <cate@debian.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Hardwired drivers are going away?
Message-ID: <20020114131050.E14747@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Mr. James W. Laferriere" <babydr@baby-dragons.com>,
	Giacomo Catenazzi <cate@debian.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0201141254001.3238-100000@filesrv1.baby-dragons.com> <E16QBX6-0002Op-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16QBX6-0002Op-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Jan 14, 2002 at 06:08:32PM +0000
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk>:
> For 2.5 if things go to plan there will be no such thing as a "compiled in"
> driver. They simply are not needed with initramfs holding what were once the
> "compiled in" modules.

This is something of a bombshell.  Not necessarily a bad one, but...

Alan, do you have *any* *freakin'* *idea* how much more complicated
the CML2 deduction engine had to be because the basic logical entity
was a tristate rather than a bool?  If this plan goes through, I'm
going to be able to drop out at least 20% of the code, with most of
that 20% being in the nasty complicated bits where the maintainability
improvement will be greatest.  And I can get rid of the nasty "vitality"
flag, which probably the worst wart on the language.

Yowza...so how soon is this supposed to happen?
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Government should be weak, amateurish and ridiculous. At present, it
fulfills only a third of the role.	-- Edward Abbey
