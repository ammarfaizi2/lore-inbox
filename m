Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751420AbVJ2GH4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbVJ2GH4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 02:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbVJ2GH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 02:07:56 -0400
Received: from smtp106.sbc.mail.re2.yahoo.com ([68.142.229.99]:8302 "HELO
	smtp106.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751420AbVJ2GHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 02:07:55 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: SPARC64: Configuration offers keyboards that don't make sense
Date: Sat, 29 Oct 2005 01:07:53 -0500
User-Agent: KMail/1.8.3
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jan-Benedict Glaw <jbglaw@lug-owl.de>
References: <200510290006.j9T066on029644@inti.inf.utfsm.cl>
In-Reply-To: <200510290006.j9T066on029644@inti.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510290107.53493.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 October 2005 19:06, Horst von Brand wrote:
> Jan-Benedict Glaw <jbglaw@lug-owl.de> wrote:
> > On Fri, 2005-10-28 17:09:31 -0300, Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
> > > On my Sun I get the following offers:
> > > 
> > >    AT Keyboard
> > >    Sun types 4 and 5
> > >    DECstation LK201/LK401
> > >    XT keyboard
> > >    Newton keyboard
> > > 
> > > Unless I am very mistaken, only the second one applies?
> > 
> > Well, the LK[24]01 was used by DECstations and VAXstations (as well as
> > some VT terminals), you can use it with a simple adaptor on any
> > machine that has a RS232 serial port. For example, I'm using such a
> > keyboard on my Athlon-based PeeCee.
> 
> Does it need some kind of "serial keyboard configuration"? Wouldn't that
> make more sense?
> 
> > > Also, configuring this one gives a non-functional keyboard (the machine is
> > > running, I can log in over SSH, but keypresses have no effect at all).
> 
> > Did the serial port register serio ports?
> 
> How can I find this out?

Just post your dmesg.. Or ssh into it and poke around /sys/bus/serio...
Sun keyboard can be autodetected AFAIK so you don't need to fiddle with
inputattach. Do you have sunsu or sunzilog drivers selected?
 
-- 
Dmitry
