Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261634AbVA3C1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261634AbVA3C1d (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 21:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261635AbVA3C1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 21:27:33 -0500
Received: from smtp815.mail.sc5.yahoo.com ([66.163.170.1]:45736 "HELO
	smtp815.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261634AbVA3C1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 21:27:31 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [PATCH 6/8] Kconfig: cleanup input menu
Date: Sat, 29 Jan 2005 21:27:28 -0500
User-Agent: KMail/1.7.2
Cc: linux-input@atrey.karlin.mff.cuni.cz, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0501292320090.7662@scrub.home> <200501291932.31430.dtor_core@ameritech.net> <Pine.LNX.4.61.0501300212170.30794@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0501300212170.30794@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501292127.29418.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 29 January 2005 20:16, Roman Zippel wrote:
> Hi,
> 
> On Sat, 29 Jan 2005, Dmitry Torokhov wrote:
> 
> > > That's fine, but why is it in the input menu? How do you suggest to make 
> > > it selectable without selecting input and without messing the menu 
> > > structure?
> > 
> > Well, probably split input into sections, one of the options would be
> > something like "Generic Input Layer" and have evdev, mousedev, etc
> > depend on it. serio will not depend on it... nor will gameport as
> > I can see someone wanting gameport_raw.
> 
> That's not the point of my patch. Feel free to restructure the input menu, 
> if you need help you can ask me, but is there any practically relevant 
> reason, that serio_raw must not depend on INPUT right now?
> 

Well, with the current Kconfig I can de-select INPUT and still select
serio and serio_raw and access my AUX port via /dev/psaux. I don't know
if anyone would really do it, but why not?

Btw, what was the point of your patch?
 

-- 
Dmitry
