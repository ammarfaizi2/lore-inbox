Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751953AbWHNJOH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751953AbWHNJOH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 05:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751964AbWHNJOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 05:14:07 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:14746 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751953AbWHNJOG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 05:14:06 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Maciej Rutecki <maciej.rutecki@gmail.com>
Subject: Re: 2.6.18-rc4-mm1
Date: Mon, 14 Aug 2006 11:12:04 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Dmitry Torokhov <dtor@mail.ru>
References: <20060813012454.f1d52189.akpm@osdl.org> <20060813121126.b1dc22ee.akpm@osdl.org> <62F8B56A.8000908@gmail.com>
In-Reply-To: <62F8B56A.8000908@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200608141112.04281.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 14 August 2022 10:42, Maciej Rutecki wrote:
> Andrew Morton napisał(a):
> > Please always do reply-to-all.
> > 
> 
> Sorry.
> 
> > 
> > 
> > Could be i8042-get-rid-of-polling-timer-v4.patch.  Please try the below
> > reversion patch, on top of rc4-mm1, thanks.
> > 
> > 
> 
> Thanks for help.
> 
> I try this patch, keyboard works, but I have other problem. When I try:
> 
> echo "standby" > /sys/power/state
> 
> system goes to standby, but keyboard stop working and CMOS clock was
> corrupted (randomize date and time e.g. Fri Feb 18 2028 13:57:43). So I
> must reset computer.

To fix the CMOS clock problem please try to unset CONFIG_PM_TRACE .

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
