Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271885AbTHDQQv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 12:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271889AbTHDQQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 12:16:51 -0400
Received: from www.13thfloor.at ([212.16.59.250]:15241 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S271885AbTHDQQt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 12:16:49 -0400
Date: Mon, 4 Aug 2003 18:16:57 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Brian Pawlowski <beepy@netapp.com>, aebr@win.tue.nl,
       linux-kernel@vger.kernel.org
Subject: Re: FS: hardlinks on directories
Message-ID: <20030804161657.GA6292@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: Stephan von Krawczynski <skraw@ithnet.com>,
	Brian Pawlowski <beepy@netapp.com>, aebr@win.tue.nl,
	linux-kernel@vger.kernel.org
References: <20030804134415.GA4454@win.tue.nl> <200308041542.h74Fg9k26251@orbit-fe.eng.netapp.com> <20030804175609.7301d075.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20030804175609.7301d075.skraw@ithnet.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 04, 2003 at 05:56:09PM +0200, Stephan von Krawczynski wrote:
> On Mon, 4 Aug 2003 08:42:09 -0700 (PDT)
> Brian Pawlowski <beepy@netapp.com> wrote:
> 
> > I'm still waking up, but '..' obviously breaks the "no cycle"
> > observations.
> 
> Hear, hear ...
> 
> > It's just that '..' is well known name by utilities as opposed
> > to arbitrary links.
> 
> Well, that leads only to the point that ".." implementation is just lousy and
> it should have been done right in the first place. If there is a need for a
> loop or a hardlink (like "..") all you have to have is a standard way to find
> out, be it flags or the like, whatever. But taking the filename or anything not
> applicable to other cases as matching factor was obviously short-sighted.

hey, why not just implement it, as a proof of concept
and see, what is broken, and what can be fixed ...

maybe your concept has a big fute, ... give it a try!

on the other hand, if you want somebody to implement
this stuff for you, you'll have to provide convincing
arguments for it, I for example, would be glad if
hardlinks where removed from unix altogether ...

best,
Herbert

> Regards,
> Stephan
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
