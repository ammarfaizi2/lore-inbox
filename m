Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288765AbSAQOHb>; Thu, 17 Jan 2002 09:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288767AbSAQOHW>; Thu, 17 Jan 2002 09:07:22 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:19592
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S288765AbSAQOHL>; Thu, 17 Jan 2002 09:07:11 -0500
Date: Thu, 17 Jan 2002 08:50:56 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Dave Jones <davej@suse.de>, Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Calling EISA experts
Message-ID: <20020117085056.B7299@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Dave Jones <davej@suse.de>, Jeff Garzik <jgarzik@mandrakesoft.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020117015456.A628@thyrsus.com> <20020117121723.B22171@suse.de> <3C46B718.26F52BD5@mandrakesoft.com> <20020117124849.F22171@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020117124849.F22171@suse.de>; from davej@suse.de on Thu, Jan 17, 2002 at 12:48:49PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@suse.de>:
>  > >  Not afaik. I'm tempted to hack support for it into driverfs.
>  > The EISA_bus global variable indicates presence...
> 
>  *nod*, though you can almost guarantee this isn't what Eric wants.
>  I'm assuming he wants something a'la /proc/pci

Bingo.  I've got reliable /proc tests for ISAPNP, PCI, and MCA.  Previous 
discussion indicates I can't get one for ISA classic.  An EISA test would,
as ever, allow me to cut the number of questions about ancient dead 
hardware that users have to see.
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
