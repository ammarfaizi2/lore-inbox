Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264384AbUE3VEc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264384AbUE3VEc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 17:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264402AbUE3VEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 17:04:31 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:23936 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S264386AbUE3U7t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 16:59:49 -0400
Date: Sun, 30 May 2004 23:00:11 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Giuseppe Bilotta <bilotta78@hotpop.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SERIO_USERDEV patch for 2.6
Message-ID: <20040530210011.GA2867@ucw.cz>
References: <xb7r7t2b3mb.fsf@savona.informatik.uni-freiburg.de> <xb7aczq9he1.fsf@savona.informatik.uni-freiburg.de> <20040530134246.GA1828@ucw.cz> <200405301009.21202.dtor_core@ameritech.net> <20040530155821.GC1479@ucw.cz> <MPG.1b2425f8267124609896ab@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MPG.1b2425f8267124609896ab@news.gmane.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 30, 2004 at 06:10:52PM +0200, Giuseppe Bilotta wrote:
> Vojtech Pavlik wrote:
> > On Sun, May 30, 2004 at 10:09:18AM -0500, Dmitry Torokhov wrote:
> > 
> > > On Sunday 30 May 2004 08:42 am, Vojtech Pavlik wrote:
> > > > 
> > > > Anyway, looking at the patch, it's not bad, and it's quite close to what
> > > > I was considering to write. I'd like to keep it separate from the
> > > > serio.c file, although it's obvious it'll require to be linked to it
> > > > statically, because it needs hooks there - it cannot be a regular serio
> > > > driver.
> > > > 
> > > 
> > > Do we really have to have this stuff directly in serio? How about being able
> > > to mark some serio ports as working in raw mode (i8042.raw=0,1,1,0) and have
> > > separate (serio_raw?) module bind to such ports
> > 
> > We don't have to. But it'd be rather convenient to have it. It would
> > work for all serio ports, not just i8042, etc, etc.
> > 
> > And if kept in a separate file (serio-dev.c), it wouldn't mess up things
> > too much.
> 
> I'm starting to get nervous about testing this stuff ... do you 
> think it will it make to 2.6.7? :)
 
No way. ;)

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
