Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263749AbTE3PNs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 11:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263750AbTE3PNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 11:13:47 -0400
Received: from almesberger.net ([63.105.73.239]:62481 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S263749AbTE3PNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 11:13:46 -0400
Date: Fri, 30 May 2003 12:26:30 -0300
From: Werner Almesberger <wa@almesberger.net>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       Carl Spalletta <cspalletta@yahoo.com>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@transmeta.com>,
       Dan Carpenter <d_carpenter@sbcglobal.net>
Subject: Re: inventing the wheel?
Message-ID: <20030530122629.C1617@almesberger.net>
References: <20030527180546.15656.qmail@web41501.mail.yahoo.com> <3ED3E224.1000402@gmx.net> <20030530113009.A1667@almesberger.net> <Pine.LNX.4.53.0305301111160.30122@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0305301111160.30122@chaos>; from root@chaos.analogic.com on Fri, May 30, 2003 at 11:12:38AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> The problem with 'correctness" is in the definition
> of 'correct'. In many cases there are hundreds of
> methods that can be used to implement a particular
> software algorithm.

Of course. Your example would probably be too low-level for
most such checkers, and might better be handled by run-time
checks (e.g. through something like valgrind).

Also, a template check wouldn't have to cover all equivalent
coding variants. E.g. if the template just allows one kind
of loop, it's probably always acceptable to change code that
uses an equivalent alternative.

Furthermore, if someone figures out a way for doing things
more efficiently, it should be easier to update drivers that
conform to a well-known status quo ante.

> One can, however, create an analysis engine that determines
> compliance with certain rules and, or, certain templates.

Yes, that's exactly what I mean.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
