Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135822AbRD3TZi>; Mon, 30 Apr 2001 15:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135842AbRD3TZ3>; Mon, 30 Apr 2001 15:25:29 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:45068 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S135822AbRD3TZK>;
	Mon, 30 Apr 2001 15:25:10 -0400
Date: Mon, 30 Apr 2001 15:25:36 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Peter Samuelson <peter@cadcamlab.org>
Cc: John Stoffel <stoffel@casc.com>, CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: CML2 1.3.1, aka "I stick my neck out a mile..."
Message-ID: <20010430152536.A29699@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Peter Samuelson <peter@cadcamlab.org>,
	John Stoffel <stoffel@casc.com>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010427193501.A9805@thyrsus.com> <15084.12152.956561.490805@gargle.gargle.HOWL> <20010429183526.B32748@thyrsus.com> <15085.37569.205459.898540@gargle.gargle.HOWL> <20010430133932.B28849@thyrsus.com> <20010430141623.A15821@cadcamlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010430141623.A15821@cadcamlab.org>; from peter@cadcamlab.org on Mon, Apr 30, 2001 at 02:16:23PM -0500
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Samuelson <peter@cadcamlab.org>:
> [esr]
> > Besides, right now the configurator has a simple invariant.  It will
> > only accept consistent configurations
> 
> So you are saying that the old 'vi .config; make oldconfig' trick is
> officially unsupported?  That's too bad, it was quite handy.

Depends on how you define `unsupported'.  Make oldconfig will tell you 
exactly and unambiguously what was wrong with the configuration.  I think 
if you're hard-core enough to vi your config, you're hard-core enough to
interpret and act on

    This configuration violates the following constraints:
    (X86 and SMP==y) implies RTC!=n

without needing some wussy GUI holding your hand :-).
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The end move in politics is always to pick up a gun.
	-- R. Buckminster Fuller
