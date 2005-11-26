Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750885AbVKZR2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbVKZR2A (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 12:28:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750854AbVKZR2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 12:28:00 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:52456 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1750828AbVKZR2A convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 12:28:00 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: psmouse unusable in -mm series (was: 2.6.15-rc1-mm2 unsusable on DELL Inspiron 8200, 2.6.15-rc1 works fine)
Date: Sat, 26 Nov 2005 18:28:58 +0100
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, Marc Koschewski <marc@osknowledge.org>,
       Ed Tomlinson <tomlins@cam.org>
References: <20051118182910.GJ6640@stiffy.osknowledge.org> <200511252254.53128.dtor_core@ameritech.net> <200511252350.28129.dtor_core@ameritech.net>
In-Reply-To: <200511252350.28129.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200511261828.58875.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 26 of November 2005 05:50, Dmitry Torokhov wrote:
> On Friday 25 November 2005 22:54, Dmitry Torokhov wrote:
> > > Actually, it works on the console (ie with gpm), but X is unable to use it,
> > > apparently.  However it used to be, at least on 2.6.14-git9 (this is the latest
> > > non-mm kernel I've been able to test quickly on this box).
> > >
> > 
> > Rafael,
> > 
> > does reverting the following patch makes touchpad work?
> 
> Or, try dropping this patch on top of -mm.

That helps (additionally I've dropped "const" from the header of
evdev_event_to_user, to avoid warnings).

Thanks,
Rafael
