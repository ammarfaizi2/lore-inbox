Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133033AbRDLAoZ>; Wed, 11 Apr 2001 20:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133034AbRDLAoP>; Wed, 11 Apr 2001 20:44:15 -0400
Received: from nat-hdqt.valinux.com ([198.186.202.17]:32035 "EHLO
	golux.thyrsus.com") by vger.kernel.org with ESMTP
	id <S133033AbRDLAoA>; Wed, 11 Apr 2001 20:44:00 -0400
Date: Wed, 11 Apr 2001 20:45:23 -0400
From: esr@thyrsus.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Christoph Hellwig <hch@caldera.de>, Dave Jones <davej@suse.de>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net,
        "Eric S. Raymond" <esr@snark.thyrsus.com>
Subject: Re: CML2 1.0.0 release announcement
Message-ID: <20010411204523.C9081@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: esr@thyrsus.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Christoph Hellwig <hch@caldera.de>, Dave Jones <davej@suse.de>,
	linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net,
	"Eric S. Raymond" <esr@snark.thyrsus.com>
In-Reply-To: <20010411191940.A9081@thyrsus.com> <E14nU6n-0007po-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14nU6n-0007po-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Apr 12, 2001 at 12:33:07AM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk>:
> Ok I see where you are going with that argument. However when you parse all
> the existing Config.in files into a tree you can see those properties by 
> looking from any node back to its dependancies

Granted.  If, that is, the representation you generate supports that kind
of backtracking.  This turns out to be very hard if you're starting from
an imperative representation rather than a declarative one.  

But, as a separate issue, the CML2 design *could* be reworked to support
a multiple-apex tree, if there were any advantage to doing so.  I don't
see one.  Do you?
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Good intentions will always be pleaded for every assumption of
authority. It is hardly too strong to say that the Constitution was
made to guard the people against the dangers of good intentions. There
are men in all ages who mean to govern well, but they mean to
govern. They promise to be good masters, but they mean to be masters.
	-- Daniel Webster
