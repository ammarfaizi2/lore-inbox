Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281228AbRLDR4C>; Tue, 4 Dec 2001 12:56:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281087AbRLDRyn>; Tue, 4 Dec 2001 12:54:43 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:44468
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S280136AbRLDRxq>; Tue, 4 Dec 2001 12:53:46 -0500
Date: Tue, 4 Dec 2001 12:44:41 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Wayne.Brown@altec.com
Cc: John Stoffel <stoffel@casc.com>, Keith Owens <kaos@ocs.com.au>,
        kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
Message-ID: <20011204124441.K16578@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Wayne.Brown@altec.com, John Stoffel <stoffel@casc.com>,
	Keith Owens <kaos@ocs.com.au>, kbuild-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <86256B18.005EE7DC.00@smtpnotes.altec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <86256B18.005EE7DC.00@smtpnotes.altec.com>; from Wayne.Brown@altec.com on Tue, Dec 04, 2001 at 11:11:50AM -0600
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wayne.Brown@altec.com <Wayne.Brown@altec.com>:
> It's not the CML1 language spec that interests me, just the user
> interface.  All I care about is being able to do make menuconfig and
> make oldconfig, and get the same results as before.  What goes on
> "under the surface" doesn't interest me at all.
> 
> In fact, here's all I want to know about the whole CML2/kbuild 2.5
> issue.  Right now I upgrade my kernel like this (simplified
> slightly):
> 
> <apply latest patches>
> mv .config ..
> make mrproper
> mv ../.config .
> make oldconfig
> make dep
> make bzlilo modules modules_install
> <reboot>
> 
> Will I still be able to do it this simply in 2.5.x?  (Assuming there's
> eventually a 2.5.x I can get to compile cleanly.  :-)

Yes.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Never trust a man who praises compassion while pointing a gun at you.
