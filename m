Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129638AbRCLIxp>; Mon, 12 Mar 2001 03:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129667AbRCLIxg>; Mon, 12 Mar 2001 03:53:36 -0500
Received: from snark.tuxedo.org ([207.106.50.26]:13061 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S129638AbRCLIxW>;
	Mon, 12 Mar 2001 03:53:22 -0500
Date: Mon, 12 Mar 2001 03:53:07 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Peter Samuelson <peter@cadcamlab.org>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org,
        elenstev@mesatop.com, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: Rename all derived CONFIG variables
Message-ID: <20010312035307.A15136@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Peter Samuelson <peter@cadcamlab.org>,
	Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org,
	elenstev@mesatop.com, kbuild-devel@lists.sourceforge.net
In-Reply-To: <20736.984380602@ocs3.ocs-net> <15020.34886.547537.353688@wire.cadcamlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15020.34886.547537.353688@wire.cadcamlab.org>; from peter@cadcamlab.org on Mon, Mar 12, 2001 at 02:26:46AM -0600
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Samuelson <peter@cadcamlab.org>:
> > In 2.4.2-ac18 there are 130 CONFIG options that are always derived
> > from other options, the user has no control over them.
> 
> I've thought about these before ... but never got around to doing
> anything about them.  I agree they should have a separate namespace.
> 
> However, I would vote the for namespace CONFIG__* rather than
> CONFIG_*_DERIVED.  As Jeff noted, _DERIVED is quite a mouthful to type,
> and CONFIG__* seems all-around less intrusive.

How much point is there to this kind of cleanup in CML1, really?

After the fall LinuxWorld meeting I was under the impression that mec
and the rest of the build team were planning to support switching to
CML2 for the 2.5 series.  If that's not true, someone should clue me
in *now*, before I go misrepresenting anybody's position at the 2.5
kickoff workshop.

But if we're going to push Linus and the kernel crew to switch to
CML2, then why invite the political tsuris of trying to get a large
patch into 2.4 now?  Maybe I'm missing something here, but this doesn't
seem necessary to me.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The IRS has become morally corrupted by the enormous power which we in
Congress have unwisely entrusted to it. Too often it acts like a
Gestapo preying upon defenseless citizens.
	-- Senator Edward V. Long
