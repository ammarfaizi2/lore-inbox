Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287155AbSABXCY>; Wed, 2 Jan 2002 18:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287160AbSABXCF>; Wed, 2 Jan 2002 18:02:05 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:4228
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S287163AbSABXBw>; Wed, 2 Jan 2002 18:01:52 -0500
Date: Wed, 2 Jan 2002 17:48:24 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Dave Jones <davej@suse.de>
Cc: Lionel Bouton <Lionel.Bouton@free.fr>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
Message-ID: <20020102174824.A21408@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Dave Jones <davej@suse.de>, Lionel Bouton <Lionel.Bouton@free.fr>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <3C338DCC.3020707@free.fr> <Pine.LNX.4.33.0201022349200.427-100000@Appserv.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0201022349200.427-100000@Appserv.suse.de>; from davej@suse.de on Wed, Jan 02, 2002 at 11:51:17PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@suse.de>:
> > Just took a quick look at dmidecode.c and auditing this code doesn't
> > seem out of reach.
> 
> Exactly. And 90% of it can be ditched.

But a setuid program *will not solve my problem*.

The person running the autoconfigurator is not and should not be doing so 
as root.  Requiring the person to stop and sun sudo just so the 
autoconfigurator can proceed is exactly the sort of pointless 
obstacle we should *not* be putting in front of users!

(Telling me to rely on dmidecode already being installed SUID is not
a good answer either.  No prizes for figuring out why.)

Ay caramba...please guys, try get your heads out of the internals
and start thinking from the *useability* angle for once!
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

"The power to tax involves the power to destroy;...the power to
destroy may defeat and render useless the power to create...."
	-- Chief Justice John Marshall, 1819.
