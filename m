Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265797AbUAKINh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 03:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265799AbUAKINh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 03:13:37 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:7351 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S265797AbUAKINa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 03:13:30 -0500
Date: Sun, 11 Jan 2004 09:13:21 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Pavel Machek <pavel@suse.cz>, kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: Do not use synaptics extensions by default
Message-ID: <20040111081321.GC25497@ucw.cz>
References: <20040110175930.GA1749@elf.ucw.cz> <20040110201057.GA1367@elf.ucw.cz> <20040110201512.GA23208@ucw.cz> <200401101852.56429.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401101852.56429.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 10, 2004 at 06:52:56PM -0500, Dmitry Torokhov wrote:
> On Saturday 10 January 2004 03:15 pm, Vojtech Pavlik wrote:
> > On Sat, Jan 10, 2004 at 09:10:58PM +0100, Pavel Machek wrote:
> > > Hi!
> > >
> > > > > > Why would you document something that is deprecated? It was
> > > > > > removed so the new users would not start using it instead of
> > > > > > psmouse.proto. psmouse.noext should be gone soon.
> > > > >
> > > > > My understanding is that Documentation/kernel-parameters.txt
> > > > > should document all available parameters...
> > > >
> > > > Well, I wouldn't mind documenting psmouse.noext, with a comment
> > > > that it shouldn't be used because it'll be removed in near future.
> > >
> > > AFAICS, it is still psmouse*_*noext in mainline kernel, so this
> > > should be correct...
> > >
> > > 								Pavel
> >
> > No problem with this patch, though it'd be better if you could provide
> > it against the -mm kernel for Andrew.
> >
> 
> In Andrew's tree noext option is already gone.

That makes the patch rather trivial then, doesn't it? ;)

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
