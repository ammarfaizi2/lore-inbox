Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289180AbSAVGKe>; Tue, 22 Jan 2002 01:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289179AbSAVGKO>; Tue, 22 Jan 2002 01:10:14 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:41124
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S289180AbSAVGKD>; Tue, 22 Jan 2002 01:10:03 -0500
Date: Tue, 22 Jan 2002 00:52:10 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Paul Gortmaker <p_gortmaker@yahoo.com>, Dave Jones <davej@suse.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Calling EISA experts
Message-ID: <20020122005210.A18883@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Paul Gortmaker <p_gortmaker@yahoo.com>, Dave Jones <davej@suse.de>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020117015456.A628@thyrsus.com> <20020117121723.B22171@suse.de> <3C46B718.26F52BD5@mandrakesoft.com> <20020117124849.F22171@suse.de> <20020117085056.B7299@thyrsus.com> <3C4C0056.4F50C3D6@yahoo.com> <3C4C12DF.36A99A66@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C4C12DF.36A99A66@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Mon, Jan 21, 2002 at 08:08:47AM -0500
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@mandrakesoft.com>:
> > Minimal approach: Register motherboard EISA ID (i.e. slot zero) ports in
> > /proc/ioports.  Works on all kernel versions.  See $0.02 patch below.
> > 
> > This is probably the least intrusive way to get what you want.  It doesn't
> > add Yet Another Proc File, and costs zero bloat to the 99.9% of us who
> > have a better chance of meeting Aunt Tillie than an EISA box.
> > 
> > Possible alternative: Create something like /proc/bus/eisa/devices which
> > lists the EISA ID (e.g. abc0123) found in each EISA slot.   This might
> > have been worthwhile some 8 years ago, but now? ....
> 
> Actually, "lsescd" should list the EISA (and ISAPNP) configuration data,
> which includes EISA id, etc.

I do not find this command on my RH7.2 system.  Can you tell me more about it?

I like the /proc/ioports approach and agree that /proc/bus/eisa/ seems like
overkill at this late date.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

He who joyfully marches to music in rank and file has already earned my
contempt.  He has been given a large brain by mistake, since for him the
spinal cord would fully suffice.
	-- Albert Einstein
