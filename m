Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264796AbSJPB3p>; Tue, 15 Oct 2002 21:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264800AbSJPB3p>; Tue, 15 Oct 2002 21:29:45 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:39433 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S264796AbSJPB3o>; Tue, 15 Oct 2002 21:29:44 -0400
Date: Wed, 16 Oct 2002 02:35:40 +0100
From: John Levon <levon@movementarian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [8/7] oprofile - dcookies need to use u32
Message-ID: <20021016013540.GA48543@compsoc.man.ac.uk>
References: <20021016000623.GA45945@compsoc.man.ac.uk> <Pine.LNX.4.44.0210151830550.1203-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210151830550.1203-100000@home.transmeta.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2002 at 06:33:51PM -0700, Linus Torvalds wrote:

> Ok, everything applied.

Thanks !

> Quite frankly, as long as the vtune user-level tools are all proprietary,
> I don't really care all that much about vtune compatibility, but if it
> turns out to be easy and convenient we might as well try to be polite
> about it (and apparently they've sorted out all the issues with their
> kernel-level code, and are happy to do that stuff all GPL'd, but since
> it's pretty useless without the tools..).

>From my discussions with the vtune people, their kernel-level stuff has
almost exactly the same needs as oprofile. So I think they have
everything they need already (and I had to go to the effort of a total
rewrite, I think they should as well ...)

In fact I don't see a reason why they couldn't just use the oprofile
code directly anyway, and just have the propietary goop read from
/dev/oprofile/buffer. Especially if that encourages them to port the
PEBS support etc.

regards
john

-- 
"It's a cardboard universe ... and if you lean too hard against it, you fall
 through." 
	- Philip K. Dick 
