Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751063AbWFZOxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751063AbWFZOxf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 10:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbWFZOxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 10:53:35 -0400
Received: from styx.suse.cz ([82.119.242.94]:2768 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1751035AbWFZOxe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 10:53:34 -0400
Date: Mon, 26 Jun 2006 16:53:32 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: dtor_core@ameritech.net
Cc: Alan Stern <stern@rowland.harvard.edu>, Andrew Morton <akpm@osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] atkbd: restore autorepeat rate after resume
Message-ID: <20060626145332.GB24275@suse.cz>
References: <Pine.LNX.4.44L0.0606261017340.9467-100000@iolanthe.rowland.org> <d120d5000606260735v6e1762d7mc278f315c3a994fb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000606260735v6e1762d7mc278f315c3a994fb@mail.gmail.com>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2006 at 10:35:44AM -0400, Dmitry Torokhov wrote:
> On 6/26/06, Alan Stern <stern@rowland.harvard.edu> wrote:
> >From: Linus Torvalds <torvalds@osdl.org>
> >
> >This patch (as728) makes the AT keyboard driver store the current
> >autorepeat rate so that it can be restored properly following a
> >suspend/resume cycle.
> >
> 
> Alan,
> 
> I think it should be a per-device, not global parameter. Anyway, I'll
> adjust adn apply, thank you.
 
You can't make it per-device when there is no device when the keyboard
isn't plugged in. ;)

-- 
Vojtech Pavlik
Director SuSE Labs
