Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265795AbUAPWE4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 17:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265766AbUAPWE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 17:04:56 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:12040 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S265795AbUAPVpB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 16:45:01 -0500
Date: Fri, 16 Jan 2004 22:44:55 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Romain Lievin <romain@rlievin.dyndns.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: True story: "gconfig" removed root folder...
In-Reply-To: <20040116074341.GA26419@rlievin.dyndns.org>
Message-ID: <Pine.LNX.4.58.0401162241440.2530@serv>
References: <1074177405.3131.10.camel@oebilgen> <Pine.LNX.4.58.0401151558590.27223@serv>
 <20040115212304.GA25296@rlievin.dyndns.org> <Pine.LNX.4.58.0401152245030.27223@serv>
 <20040116074341.GA26419@rlievin.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 16 Jan 2004, Romain Lievin wrote:

> > What do you mean with "destroyed"? All I can reproduce here is that it's
> > simply moved away, but it's still there!
>
> I mean "destroyed" because my 'root' directory did not exist anymore. When I do
> a 'ls', I just see a 'root' file with config within.
> Well, "destroyed" may not be the best word. I can tell that it vanished somewhere.
> Anyways, I don't have any '*.old' file or directory after that.

It would be nice if you could try to find out, what exactly happens with
the directory, the save routine does only a rename...

bye, Roman
