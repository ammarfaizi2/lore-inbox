Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272634AbTG1CJs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 22:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272638AbTG1CJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 22:09:32 -0400
Received: from www.13thfloor.AT ([212.16.59.250]:25486 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S272634AbTG1CIj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 22:08:39 -0400
Date: Mon, 28 Jul 2003 04:23:36 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Adrian Bunk <bunk@fs.tum.de>, "David D. Hagood" <wowbagger@sktc.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: time for some drivers to be removed?
Message-ID: <20030728022336.GC32505@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Adrian Bunk <bunk@fs.tum.de>, "David D. Hagood" <wowbagger@sktc.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.53.0307240817520.19533@localhost.localdomain> <20030727153118.GP22218@fs.tum.de> <3F23F6EB.7070502@sktc.net> <1059324018.13442.0.camel@dhcp22.swansea.linux.org.uk> <3F241DC0.7080408@sktc.net> <1059338443.13875.2.camel@dhcp22.swansea.linux.org.uk> <20030727205638.GD22218@fs.tum.de> <1059339370.13871.4.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1059339370.13871.4.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 27, 2003 at 09:56:11PM +0100, Alan Cox wrote:
> On Sul, 2003-07-27 at 21:56, Adrian Bunk wrote:
> > That's no problem for me.
> > 
> > The only question is how to call the option that allows building only on
> > UP (e.g. cli/sti usage in the driver)? My suggestion was BROKEN_ON_SMP,
> > would you suggest OBSOLETE_ON_SMP?
> 
> Interesting question - whatever I guess. We don't have an existing convention.
> How many drivers have we got nowdays that failing on just SMP ?

I'm no native speaker, but Webster says:

obsolete:

 a) no longer in use or no longer useful 
 b) of a kind or style no longer current

broken:

 2) damaged or altered by breaking
 5) not complete or full

so I would prefer BROKEN over OBSOLETE, at least
for drivers which are known _not_ to work as expected,
but OBSOLETE over BROKEN for oldfashioned, but working
drivers superceeded by newer ones ...

JMHO,
Herbert

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
