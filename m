Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261277AbVCOOfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbVCOOfY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 09:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbVCOOfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 09:35:24 -0500
Received: from styx.suse.cz ([82.119.242.94]:16805 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261277AbVCOOfU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 09:35:20 -0500
Date: Tue, 15 Mar 2005 15:36:02 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: dtor_core@ameritech.net
Cc: Helge Hafting <helge.hafting@aitel.hist.no>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-mm3 mouse oddity
Message-ID: <20050315143602.GA3245@ucw.cz>
References: <20050312034222.12a264c4.akpm@osdl.org> <4236D428.4080403@aitel.hist.no> <d120d50005031506252c64b5d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d50005031506252c64b5d2@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2005 at 09:25:45AM -0500, Dmitry Torokhov wrote:

> Vojtech activated scroll handling in keyboard code by default so now
> your keyboard is mapped to the mouse0 and the mouse moved to mouse1.
> 
> Vojtech, is is possible to detect whether a keyboard has scroll
> wheel(s) by its ID?

If it were, I'd already have used it.

> > This is a mouse connected to the ps2 port, also appearing as /dev/psaux
> 
> I'd recommend using /dev/input/mice unless you want to _exclude_ some
> of your input devices. It will get data from all you mice at once and
> is always available.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
