Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285608AbRL1BSV>; Thu, 27 Dec 2001 20:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285591AbRL1BSL>; Thu, 27 Dec 2001 20:18:11 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:58575
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S285589AbRL1BSB>; Thu, 27 Dec 2001 20:18:01 -0500
Date: Thu, 27 Dec 2001 20:02:38 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA core vs. ISA card support
Message-ID: <20011227200238.B26889@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20011227194444.A26341@thyrsus.com> <E16Jlc8-0007ZK-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16Jlc8-0007ZK-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Dec 28, 2001 at 01:15:12AM +0000
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk>:
> I have tested on a couple of legacy free boxes. However they still have
> what were once ISA devices lurking (IDE initial setup etc). Many PCI only
> boxes have serial ports, parallel, floppy, even ISA style audio devices
> on the mainboard internal busses
> 
> ISA slots I agree is a useful distinction however

Thanks, that's helpful.  I'll introduce an ISA_SLOTS private symbol, then.
Later perhaps we can actually make this distinction in C code;  sounds
like it would be a good idea.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The biggest hypocrites on gun control are those who live in upscale
developments with armed security guards -- and who want to keep other
people from having guns to defend themselves.  But what about
lower-income people living in high-crime, inner city neighborhoods?
Should such people be kept unarmed and helpless, so that limousine
liberals can 'make a statement' by adding to the thousands of gun laws
already on the books?"
	--Thomas Sowell
