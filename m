Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261449AbVFAQHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbVFAQHK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 12:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbVFAQGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 12:06:10 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:49333 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261452AbVFAQFR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 12:05:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Jem+eL7BjKikbbl+WP9IrUsXijg8pv1mz6fBvSYOrZhUR8b4B2CZ+9j/MJYNeDor3ejkSVjfLZzUE5dZOikMXSrYNpzIFS0sCN+u2qSyyM7aTrijTw26BAGo56dC5wtYn87ae+XrVvmbKsoZ4rZJ7GtVTw5RTZhdWJ88lVIP7Zs=
Message-ID: <d120d50005060109051f9ade82@mail.gmail.com>
Date: Wed, 1 Jun 2005 11:05:15 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: OT] Joerg Schilling flames Linux on his Blog
Cc: toon@hout.vanvergehaald.nl, mrmacman_g4@mac.com, ltd@cisco.com,
       linux-kernel@vger.kernel.org, 7eggert@gmx.de
In-Reply-To: <429DDA07.nail7BFA4XEC5@burner>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <26A66BC731DAB741837AF6B2E29C10171E60DE@xmb-hkg-413.apac.cisco.com>
	 <20050530093420.GB15347@hout.vanvergehaald.nl>
	 <429B0683.nail5764GYTVC@burner>
	 <46BE0C64-1246-4259-914B-379071712F01@mac.com>
	 <429C4483.nail5X0215WJQ@burner> <20050531172204.GD17338@voodoo>
	 <d120d500050531122879868bae@mail.gmail.com>
	 <429DDA07.nail7BFA4XEC5@burner>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/05, Joerg Schilling <schilling@fokus.fraunhofer.de> wrote:
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
> > Yes it could but why should it? The purpose of udev is to maintain
> > dynamic /dev. Do you want to have thoustands quirks in udev to cope
> > with bazillion configuration files for utilities whose authors refuse
> > to adopt standard naming convention [for the operating system in
> > question].
> 
> You show exactly the habbit that makes me unwiling to believe it makes
> sense to put effort into anything in Linux that is not at least 5 years old.
> 
> 10 Years ago, Linux was completely unsuable with Linux /dev/sg* naming
^^^^^^^^^^^^^^^^^^
> and mapping conventions. After I did develop an abstraction layer that
> made Linux usable people could use stable dev= parameters across
> reboots of Linux.

Joerg, that is the problem. It was 10 years ago. USB was not existant,
Firewire wasn't there, FC, etc. You could rely on your naming then.
But it was last millenium, now dev= parameters are anything but
stable. It just does not cut anymore, while using device node to
specify device you want to work with is natural. And I am willing to
bet if you give this oprion to users of other Unix-like OSes they
would not complain either.

-- 
Dmitry
