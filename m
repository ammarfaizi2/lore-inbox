Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288177AbSACDtb>; Wed, 2 Jan 2002 22:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288176AbSACDtL>; Wed, 2 Jan 2002 22:49:11 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:18821
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S288173AbSACDtG>; Wed, 2 Jan 2002 22:49:06 -0500
Date: Wed, 2 Jan 2002 22:35:23 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Dave Jones <davej@suse.de>, Lionel Bouton <Lionel.Bouton@free.fr>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
Message-ID: <20020102223523.A27644@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Brian Gerst <bgerst@didntduck.org>, Dave Jones <davej@suse.de>,
	Lionel Bouton <Lionel.Bouton@free.fr>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020102220333.A26713@thyrsus.com> <Pine.LNX.4.33.0201030420160.6449-100000@Appserv.suse.de> <20020102221845.A27252@thyrsus.com> <3C33D1B0.4DFDF76E@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C33D1B0.4DFDF76E@didntduck.org>; from bgerst@didntduck.org on Wed, Jan 02, 2002 at 10:36:16PM -0500
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst <bgerst@didntduck.org>:
> > Not in this case.  If the DMI read fails, the worst-case result is the
> > user sees some ISA extra questions.
> 
> No, the worst case is if the DMI read says no ISA slots when there
> really are some, and the user misses a driver that he needs.

Nobody has told me this is a real failure case yet.  To cause a problem,
the situation would have to be that DMI read fails to detect a card in
use in an ISA slot.  It's OK if it reports no slots when all slots are
empty.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The possession of arms by the people is the ultimate warrant
that government governs only with the consent of the governed.
        -- Jeff Snyder
