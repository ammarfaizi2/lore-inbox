Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbUE2Wk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbUE2Wk4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 18:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbUE2Wk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 18:40:56 -0400
Received: from smtp803.mail.sc5.yahoo.com ([66.163.168.182]:11900 "HELO
	smtp803.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261179AbUE2Wky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 18:40:54 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Fw: Re: keyboard problem with 2.6.6
Date: Sat, 29 May 2004 17:40:45 -0500
User-Agent: KMail/1.6.2
Cc: Vojtech Pavlik <vojtech@suse.cz>, Giuseppe Bilotta <bilotta78@hotpop.com>
References: <20040528154307.142b7abf.akpm@osdl.org> <MPG.1b22ab00a1ccd0799896a3@news.gmane.org> <20040529133704.GA6258@ucw.cz>
In-Reply-To: <20040529133704.GA6258@ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405291740.45583.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 29 May 2004 08:37 am, Vojtech Pavlik wrote:
> > > One more thought: The emulated PS/2 mouse so many people are complaining
> > > about is there only because applications like X cannot use the native
> > > event interface. It was intended to be removed after that support is
> > > added, but with X development being as slow as it is, it didn't ever
> > > happen.
> > 
> > WRT this, would it be possible to create a GPM driver for the 
> > event interface?
> 
> Yes. Even better, it exists. And I though it's been integrated into GPM
> as well, but I might be wrong on this one.

Unfortunately evdev support in stock GPM is pretty much non-existant. It does
not use EV_SYNC and only works for relative devices. I have set of patches
that I consider proper implementation of user side of evdev interface, but I
am not sure if it is going to be included in GPM proper. For what it worth it
is in Fedora Code 2.

Now if I only had time to finish hotplug support for GPM...

-- 
Dmitry

http://www.geocities.com/dt_or/gpm/gpm.html
