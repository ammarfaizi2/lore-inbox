Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287986AbSABXZy>; Wed, 2 Jan 2002 18:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287972AbSABXYO>; Wed, 2 Jan 2002 18:24:14 -0500
Received: from tourian.nerim.net ([62.4.16.79]:11023 "HELO tourian.nerim.net")
	by vger.kernel.org with SMTP id <S287973AbSABXXr>;
	Wed, 2 Jan 2002 18:23:47 -0500
Message-ID: <3C339681.3080100@free.fr>
Date: Thu, 03 Jan 2002 00:23:45 +0100
From: Lionel Bouton <Lionel.Bouton@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020101
X-Accept-Language: en-us
MIME-Version: 1.0
To: esr@thyrsus.com
Cc: Dave Jones <davej@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <3C338DCC.3020707@free.fr> <Pine.LNX.4.33.0201022349200.427-100000@Appserv.suse.de> <20020102174824.A21408@thyrsus.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric S. Raymond wrote:

> [...]
> The person running the autoconfigurator is not and should not be doing so 
> as root.  Requiring the person to stop and sun sudo just so the 
> autoconfigurator can proceed is exactly the sort of pointless 
> obstacle we should *not* be putting in front of users!
> 
> (Telling me to rely on dmidecode already being installed SUID is not
> a good answer either.  No prizes for figuring out why.)
> 
> Ay caramba...please guys, try get your heads out of the internals
> and start thinking from the *useability* angle for once!
> 

Eric I see your point now. But stop me if I don't get the idea behind 
your autoconfigurator :
Guessing the hardware configuration is done in order to ease the whole 
configuration process. After polishing the configuration - no need for 
root priviledge - the user start the build process that doesn't need 
root priviledge either.
But when the user gets the resulting kernel how does (s)he avoid suing 
to root in order to *install* it and its modules ?
I'm not familiar with people configuring and compiling kernels for 
pleasure. They usually want to boot it...

Your whole point here is not to avoid several su instead of 1?

LB.

