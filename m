Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263166AbUEBRFZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263166AbUEBRFZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 13:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263167AbUEBRFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 13:05:25 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:22230 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S263166AbUEBRFU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 13:05:20 -0400
Date: Sun, 2 May 2004 19:05:20 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Filesystem with multiple mount-points
Message-ID: <20040502170519.GA9255@MAIL.13thfloor.at>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0405021508210.834-100000@poirot.grange> <Pine.LNX.4.58L0.0405021712280.31153@ahriman.bucharest.roedu.net> <6ur7u2izmj.fsf@zork.zork.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ur7u2izmj.fsf@zork.zork.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 02, 2004 at 05:04:52PM +0100, Sean Neakums wrote:
> GNU/Dizzy <dizzy@roedu.net> writes:
> 
> > How about mounting the big volume somewhere and using -o bind to mount 
> > some paths within it in different places of your needs ? I know that -o 
> > bind doesnt honor -o ro yet but if you really needed maybe you can make a 
> > patch for that, I for one would be very interested about that.
> 
> Herbert Poetzl's bind mount extensions should fit the bill here.
> I am unsure of the current status of the patches, though.

current status is simple, there are patches for
kernel 2.4 and 2.6 available, maybe a little outdated
but that should not be too hard to fix, if there is
some interest (so let me know ;).

I started to prepare those patches for inclusion
in mainline, but the first patch (atime) still has
not been included so I delayed the other patches,
because I do not want to walk an empty mile ...

best,
Herbert

