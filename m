Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265315AbUGGTEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265315AbUGGTEm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 15:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265331AbUGGTEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 15:04:42 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:54663 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S265315AbUGGTEl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 15:04:41 -0400
Date: Wed, 7 Jul 2004 21:05:08 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.7-mm6
Message-ID: <20040707190508.GA2980@ucw.cz>
References: <20040705023120.34f7772b.akpm@osdl.org> <200407070015.39507.dtor_core@ameritech.net> <20040707163103.GA1368@ucw.cz> <200407071215.53350.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407071215.53350.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2004 at 12:15:52PM -0500, Dmitry Torokhov wrote:
> On Wednesday 07 July 2004 11:31 am, Vojtech Pavlik wrote:
> > On Wed, Jul 07, 2004 at 12:15:37AM -0500, Dmitry Torokhov wrote:
> > > The only suspicious thing that I see is that sunzilog tries to register its
> > > serio ports with spinlock held and interrupts off. I wonder if that is what
> > > causing a deadlock. Could you please try applying this patch on top of the
> > > changes to the drivers/Makefile that I sent earlier.
> > 
> > Shall I add this to my BK then?
> > 
> 
> I was planning on pushing some updates to you later tonight, but if you want
> you can just apply that patch. The change to Makefile is also needed.
 
I can wait for the pull. ;)

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
