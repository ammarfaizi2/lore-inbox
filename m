Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289739AbSAOXTR>; Tue, 15 Jan 2002 18:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289741AbSAOXTI>; Tue, 15 Jan 2002 18:19:08 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:56707
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S289739AbSAOXS4>; Tue, 15 Jan 2002 18:18:56 -0500
Date: Tue, 15 Jan 2002 18:02:19 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Greg KH <greg@kroah.com>
Cc: Giacomo Catenazzi <cate@debian.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Autoconfiguration: Original design scenario
Message-ID: <20020115180219.A11058@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Greg KH <greg@kroah.com>, Giacomo Catenazzi <cate@debian.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <3C4401CD.3040408@debian.org> <20020115105733.B994@flint.arm.linux.org.uk> <3C442395.8010500@debian.org> <20020115183432.GC27059@kroah.com> <20020115133130.A3197@thyrsus.com> <20020115230721.GA29020@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020115230721.GA29020@kroah.com>; from greg@kroah.com on Tue, Jan 15, 2002 at 03:07:21PM -0800
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com>:
> > Giacomo will probably answer definitively, but I believe he is already
> > generating all of the PCI, PNP, and module probes by script.  We're
> > planning to ship the probe table generator with a future CML2 version.
> 
> Why not just have the probe table automatically generated against the
> current kernel?  That way you don't have to release a new version of the
> autoconfigure program for _every_ kernel version (including the -pre
> versions.)

Mainly because there is a certain amount of hand-hacking involved in
turning the raw output of the probe table generator into a usable
probe table.

Giacomo is trying to cut down on this and may eliminate it altogether.
If he doesn't, I'll take a swing at it myself.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Government is actually the worst failure of civilized man. There has
never been a really good one, and even those that are most tolerable
are arbitrary, cruel, grasping and unintelligent.	-- H. L. Mencken 
