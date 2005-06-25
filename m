Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261207AbVFYNIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbVFYNIg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 09:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbVFYNIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 09:08:32 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:63686 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261207AbVFYNI2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 09:08:28 -0400
Date: Sat, 25 Jun 2005 15:08:33 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       Stuart Shelton <stuart@zeus.com>, Daniel Drake <dsd@gentoo.org>,
       Alan Lake <alan.lake@lakeinfoworks.com>, petero2@telia.co.uk
Subject: Re: ALPS touchpad issues still exist in 2.6.12-rc4h
In-Reply-To: <20050625124818.GA1385@ucw.cz>
Message-ID: <Pine.LNX.4.61.0506251504180.3743@scrub.home>
References: <42801AEE.5080308@lakeinfoworks.com> <d120d5000505101520ad1761@mail.gmail.com>
 <1115767038.12779.36.camel@callisto.dnsalias.net> <200505102059.36744.dtor_core@ameritech.net>
 <Pine.LNX.4.61.0506251431340.3743@scrub.home> <20050625124818.GA1385@ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 25 Jun 2005, Vojtech Pavlik wrote:

> > I skipped 2.6.11 on my laptop, so I'm only noticing this problem now.
> > You didn't really answer the question, why has the _default_ been changed, 
> > giving users the possibility to change the defaults is fine, but why is it 
> > necessary to break existing setups?
>  
> Because we added a driver for the pad. There was none before and the pad
> had to work in compatibility mode. It seems more beneficial to me to
> have the driver enabled by default (saving a lot of #ifdefs) than to
> keep perfect compatibility with a no-driver situation.

Adding a driver for it is nice, but that still doesn't question: why does 
it change the default settings? If you can't restore the defaults 
settings, then just detect the hardware but don't change it until it's 
explicitely requested somehow.

bye, Roman
