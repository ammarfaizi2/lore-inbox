Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270520AbTHQTSJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 15:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270524AbTHQTSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 15:18:08 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:25472 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S270520AbTHQTSA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 15:18:00 -0400
Date: Sun, 17 Aug 2003 20:17:39 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Jan Rychter <jan@rychter.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Centrino support
Message-ID: <20030817191739.GA3305@mail.jlokier.co.uk>
References: <m2wude3i2y.fsf@tnuctip.rychter.com> <1060972810.29086.8.camel@serpentine.internal.keyresearch.com> <3F3D469B.2020507@yahoo.com> <20030816123410.56cbb550.skraw@ithnet.com> <m2isoxgys4.fsf@tnuctip.rychter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2isoxgys4.fsf@tnuctip.rychter.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Rychter wrote:
> >>>>> "Stephan" == Stephan von Krawczynski <skraw@ithnet.com>:
>  Stephan> I think I have read in an earlier thread something the like.
>  Stephan> But I cannot understand how this can be logically linked to
>  Stephan> releasing docs. If all companies would follow this thought
>  Stephan> e.g. Siemens would never have released the docs for ISDN
>  Stephan> chipsets and therefore no ISDN drivers would be in the
>  Stephan> kernel. I'd rather say someone with money is afraid ...
> 
> Yes, that sounds rather ridiculous. Sooner or later someone is going to
> reverse-engineer the thing, so not releasing drivers or specs just
> delays this moment. If there's a manager at Intel that thinks this way,
> he doesn't understand much about security.

Let's be fair to Intel for a moment.

With hardware radios, anyone can open it up, fiddle with electronics,
and make it do something illegal, possibly dangerous.  Manufacturers
aren't required to make them impregnable!

All manufacturers have to do is not put any knobs on the front which
can make the radio do unapproved things.

Folk are allowed to fiddle with radio electronics, with care, as long
as they get themselves a radio license and stick to the rules.

They can even sell an altered device, if they take it through the FCC
approval process.

With a software radio, it's analagous.  The manufacturer doesn't have
to make it _impossible_ to reprogram, they just have to make it hard
enough that ordinary users won't do it.

Releasing the source code may or may not result in ordinary users
reprograming their radios in harmful ways.  Though, you can imagine
people would circulate patches to boost the power in no time.

At least there is some hope for the expert hobbyist: they _can_
reverse engineer the device.  It is good that this is possible.

If Intel build a crypto-based authentication mechanism into their
software radios, then there is no hope for the amateur radio hobbyist
to fiddle with their radios.

So, really, Intel has done the amateur radio community a favour by
leaving the tantalising possibility of reverse engineering the driver,
compared with a DRM solution which totally prevents even expert tinkering.

-- Jamie
