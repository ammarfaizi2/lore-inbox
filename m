Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289887AbSAPGth>; Wed, 16 Jan 2002 01:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290375AbSAPGt1>; Wed, 16 Jan 2002 01:49:27 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:38528
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S289887AbSAPGtP>; Wed, 16 Jan 2002 01:49:15 -0500
Date: Wed, 16 Jan 2002 01:32:50 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Peter Samuelson <peter@cadcamlab.org>
Cc: Rob Landley <landley@trommello.org>, Nicolas Pitre <nico@cam.org>,
        lkml <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: CML2-2.1.3 is available
Message-ID: <20020116013250.A3880@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Peter Samuelson <peter@cadcamlab.org>,
	Rob Landley <landley@trommello.org>, Nicolas Pitre <nico@cam.org>,
	lkml <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.33.0201151538340.5892-100000@xanadu.home> <20020116034137.CRFB26021.femail12.sdc1.sfba.home.com@there> <20020115224821.A4658@thyrsus.com> <20020116062942.GC2067@cadcamlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020116062942.GC2067@cadcamlab.org>; from peter@cadcamlab.org on Wed, Jan 16, 2002 at 12:29:42AM -0600
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Samuelson <peter@cadcamlab.org>:
> > The version I just released does exactly that.  Well, not exactly; it
> > actually looks at fstab -- /proc/mounts gives you '/dev/root' rather
> > than a physical device name in the root entry.
> 
> /etc/fstab is hardly guaranteed to be accurate either.  The kernel
> mounts the root device based on its command line and any pivot_root()
> calls you make, not based on /etc/fstab.
> 
> [In practice, I imagine most people don't lie to fstab.  The fsck init
> script would get annoyed.]

Agreed.  The root device getting overridden by either of these means 
is well into the territory an autoconfigurator cannot be reasonably
expected to cover.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Faith may be defined briefly as an illogical belief in the occurrence
of the improbable...A man full of faith is simply one who has lost (or
never had) the capacity for clear and realistic thought. He is not a
mere ass: he is actually ill.	-- H. L. Mencken 
