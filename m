Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262571AbTJAVUr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 17:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262570AbTJAVUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 17:20:47 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:24962
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S262555AbTJAVUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 17:20:45 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Andries Brouwer <aebr@win.tue.nl>
Subject: Re: Keyboard dead on bootup on -test6.
Date: Wed, 1 Oct 2003 16:17:39 -0500
User-Agent: KMail/1.5
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
References: <200309301632.01498.rob@landley.net> <200309302021.56614.rob@landley.net> <20031001183648.GB1686@win.tue.nl>
In-Reply-To: <20031001183648.GB1686@win.tue.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310011617.39953.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 October 2003 13:36, Andries Brouwer wrote:
> On Tue, Sep 30, 2003 at 08:21:56PM -0500, Rob Landley wrote:
> > > > Sep 30 16:17:31 localhost kernel: atkbd.c: Unknown key pressed (raw
> > > > set 0, code 0xfc, data 0xfc, on isa0060/serio1).
> > >
> > > I suppose this is the kernel trying to set LEDs on the mouse,
> > > and the mouse complains.
> >
> > There are no LED's anywhere near it.  So I'm not surprised it complains.
> > But why does that kill my keyboard?
>
> I can conjecture, but reading the facts is easier if you have a debug log
> (#define DEBUG in i8042.c).
>
> [In case you already sent one, point at the URL - I've seen so many
> recently I lost track who reported what.]

I'll #define that net recompile and let you know.

Will this make /var/log/messages bigger, or does it do something else?

Rob
