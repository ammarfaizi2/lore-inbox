Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319210AbSHTRZs>; Tue, 20 Aug 2002 13:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319197AbSHTRZs>; Tue, 20 Aug 2002 13:25:48 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:9741 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S319210AbSHTRZq>; Tue, 20 Aug 2002 13:25:46 -0400
Date: Tue, 20 Aug 2002 19:29:38 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] devfs cleanups for 2.5.29
In-Reply-To: <200208201700.g7KH0Qr10235@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.LNX.4.44.0208201923470.28515-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 20 Aug 2002, Richard Gooch wrote:

> > So where again is the module count
> > incremented?
>
> Which kernel tree are you looking at? I'm looking at 2.4.20-pre4.

Try 2.5.x.

> > You never answered my question, why you insist on managing the ops
> > pointer. The far easier fix would be to simply remove this nonsense.
>
> Because it's an optimsation, avoiding the need for looking up ops from
> tables/lists. It's the sensible way of doing it. I've explained this
> to others on the list, and in the FAQ. I'm not going to keep going
> over it again and again.

Optimization??? This would require any device had to be be opened _only_
through devfs, you are not seriously suggesting that???

bye, Roman

