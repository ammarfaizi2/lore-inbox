Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316952AbSFFLWf>; Thu, 6 Jun 2002 07:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316953AbSFFLWe>; Thu, 6 Jun 2002 07:22:34 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:22231 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S316952AbSFFLWd>; Thu, 6 Jun 2002 07:22:33 -0400
Date: Thu, 6 Jun 2002 13:22:34 +0200
From: Jan Hudec <bulb@ucw.cz>
To: kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
Subject: Re: Load kernel module automatically
Message-ID: <20020606112234.GA20035@artax.karlin.mff.cuni.cz>
Mail-Followup-To: Jan Hudec <bulb@ucw.cz>,
	kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
In-Reply-To: <3CFD19D1.5768FCF8@compro.net> <20020605194716.4290.qmail@web14906.mail.yahoo.com> <20020606085907.GA28704@artax.karlin.mff.cuni.cz> <3CFF2880.8D697F90@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2002 at 05:16:48AM -0400, Mark Hounschell wrote:
> That isn't the case.  There is no /etc/modules file on any Linux box I've
> ever used. My network driver modules are loaded automatically by the kernel's
> internal module loader "kmod" because the are set up correctly in /etc/modules.conf.
> 
> "alias eth0 3c905"
> 
> ALL device driver modules can be set up to load automatacally by "kmod".

That I didn't know. However, I have a computer with four network cards
in it. Since they are numbered dynamicaly, loading modules in different
order results in different numbering of devices. How do I assure that
upon request for eg. eth2 the loaded module is assigned eth2?


--------------------------------------------------------------------------------
                  				- Jan Hudec `Bulb' <bulb@ucw.cz>
