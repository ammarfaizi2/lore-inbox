Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbTIWRWP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 13:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262118AbTIWRWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 13:22:15 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:30726 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S262115AbTIWRWL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 13:22:11 -0400
Date: Tue, 23 Sep 2003 19:22:06 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Norman Diamond <ndiamond@wta.att.ne.jp>
Cc: Andries Brouwer <aebr@win.tue.nl>, Vojtech Pavlik <vojtech@suse.cz>,
       linux-kernel@vger.kernel.org, John Bradford <john@grabjohn.com>
Subject: Re: 2.6.0-test5 vs. Japanese keyboards
Message-ID: <20030923192206.A1504@pclin040.win.tue.nl>
References: <1b7301c37a73$861bea70$2dee4ca5@DIAMONDLX60> <20030921110125.GB18677@ucw.cz> <0a5f01c38043$f9c35c80$44ee4ca5@DIAMONDLX60> <20030921171632.A11359@pclin040.win.tue.nl> <0c2001c38104$34c2a690$44ee4ca5@DIAMONDLX60> <20030922221453.A1064@pclin040.win.tue.nl> <145601c381c8$07956760$44ee4ca5@DIAMONDLX60>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <145601c381c8$07956760$44ee4ca5@DIAMONDLX60>; from ndiamond@wta.att.ne.jp on Tue, Sep 23, 2003 at 08:44:12PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > I think no kernel changes are required to use Japanese keyboards
> > > > today.
> > > > (But kbd has to be recompiled with NR_KEYS set to 256.)
> > >
> > > I'm not convinced yet.  defkeymap.c_shipped is included in the
> > > downloadable .bz2 file and it is inadequate.
> >
> > But defkeymap is inadequeate for German, it is inadequate for French,
> > why would it be adequate for Japanese?
> 
> I think that if defkeymap.c_shipped were inadequate for German and French
> then you already would have fixed it.  I don't have experience with those
> keyboards but would guess that defkeymap.c_shipped is probably adequate for
> loadkeys to load a working keymap for German or French.

Of course. It is also adequate for loadkeys to load a working keymap
for Japanese.

> In order to be capable of loading a working keymap, defkeymap.c_shipped
> needs patching.

No.

> > It is just the random default you get when no keymap was loaded.
> 
> It is that plus more.  It includes limits that prevent certain keymaps from
> getting set when loaded.

False.

Andries

