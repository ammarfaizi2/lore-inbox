Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261876AbVA3XkQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbVA3XkQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 18:40:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261864AbVA3XkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 18:40:15 -0500
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:64370 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261861AbVA3Xjn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 18:39:43 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [PATCH 6/8] Kconfig: cleanup input menu
Date: Sun, 30 Jan 2005 18:39:37 -0500
User-Agent: KMail/1.7.2
Cc: linux-input@atrey.karlin.mff.cuni.cz, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0501292320090.7662@scrub.home> <200501292307.55193.dtor_core@ameritech.net> <Pine.LNX.4.61.0501301639171.30794@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0501301639171.30794@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501301839.37548.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 30 January 2005 10:45, Roman Zippel wrote:
> Hi,
> 
> On Sat, 29 Jan 2005, Dmitry Torokhov wrote:
> 
> > Ok, what about making some submenus to manage number of options, like in
> > the patch below?
> 
> I'd rather move it to the bottom and the menus had no dependencies.
> Below is an alternative patch, which does a rather complete cleanup.

This one looks nice. I still think that hardware port support should go
first. My argument is:

When I go into a menu I explore option and submenus from top to bottom.
So I will see PS/2 or serial, and will go there and select what I need.
Then I will see that generic input layer is also needed for keyboard
and go there.

If generic layer is first one I select options I think are needed I could
skip over the HW I/O ports thinking that I already selected everything I
need as far as keyboard/mouse goes.

Does this make any sense?
 
-- 
Dmitry
