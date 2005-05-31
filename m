Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261473AbVEaVAo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbVEaVAo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 17:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbVEaVAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 17:00:44 -0400
Received: from atpro.com ([12.161.0.3]:59910 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S261473AbVEaVAg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 17:00:36 -0400
From: "Jim Crilly" <jim@why.dont.jablowme.net>
Date: Tue, 31 May 2005 16:54:49 -0400
To: dtor_core@ameritech.net
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>, mrmacman_g4@mac.com,
       toon@hout.vanvergehaald.nl, ltd@cisco.com, linux-kernel@vger.kernel.org,
       7eggert@gmx.de
Subject: Re: OT] Joerg Schilling flames Linux on his Blog
Message-ID: <20050531205449.GG17338@voodoo>
Mail-Followup-To: dtor_core@ameritech.net,
	Joerg Schilling <schilling@fokus.fraunhofer.de>, mrmacman_g4@mac.com,
	toon@hout.vanvergehaald.nl, ltd@cisco.com,
	linux-kernel@vger.kernel.org, 7eggert@gmx.de
References: <26A66BC731DAB741837AF6B2E29C10171E60DE@xmb-hkg-413.apac.cisco.com> <20050530093420.GB15347@hout.vanvergehaald.nl> <429B0683.nail5764GYTVC@burner> <46BE0C64-1246-4259-914B-379071712F01@mac.com> <429C4483.nail5X0215WJQ@burner> <20050531172204.GD17338@voodoo> <d120d500050531122879868bae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d500050531122879868bae@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/31/05 02:28:16PM -0500, Dmitry Torokhov wrote:
> Yes it could but why should it? The purpose of udev is to maintain
> dynamic /dev. Do you want to have thoustands quirks in udev to cope
> with bazillion configuration files for utilities whose authors refuse
> to adopt standard naming convention [for the operating system in
> question].

I didn't say it was a good idea, just that it was possible to do what he
wants.

> 
> I do not understand why Joerg is so fixed on presenting SCSI interface
> to userspace. Why when I mount just burned CD I can use /dev/scd0 but
> for writing it I should say dev=5,4,0?? I do not really care that
> internally X,Y,Z might or might not used, they should not be exposed
> to userspace, especially since days when they could be used for static
> device identification are long gone.

I totally agree, whenever I use cdrecord I use dev=/dev/whatever and will
continue to do so until it no longer works. But if that ever happens I
would hope another tool would take it's place. And contrary to what he
believes I also burned as a non-root user so it wasn't able to set itself
to rt or mlock itself into memory and I've never burned a coaster that I
could blame on either case even on my slowest machines.

> -- 
> Dmitry

Jim.
