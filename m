Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265759AbSLQTPY>; Tue, 17 Dec 2002 14:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266292AbSLQTPY>; Tue, 17 Dec 2002 14:15:24 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:25573 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S265759AbSLQTOi>; Tue, 17 Dec 2002 14:14:38 -0500
Date: Tue, 17 Dec 2002 14:22:35 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: My fixes to ide-tape in 2.4.20-ac2
Message-ID: <20021217142235.C8233@devserv.devel.redhat.com>
References: <20021213224424.A3446@devserv.devel.redhat.com> <Pine.LNX.4.50L.0212162248480.31876-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.50L.0212162248480.31876-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Mon, Dec 16, 2002 at 10:49:35PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Mon, 16 Dec 2002 22:49:35 -0200 (BRST)
> From: Marcelo Tosatti <marcelo@conectiva.com.br>

> > I checked that my fixes were not corrected by Alan Stern,
> > and re-diffed them against 2.4.20-ac2. I think it would
> > be right if Alan (Cox :-) applied this patch to -ac3 or something.
> > Marcelo agreed to take it many times but forgot to actually apply.
> 
> I haven't applied them because I was afraid they could break something.
> 
> Great that now its been tested in -ac.

Yes, Alan saves the day. However, I would think this is what your
-pre series were supposed to do. Add fixes, see if they break things.
Release more often. If patches regress, remove them. Obviously, your
master vision is different, but personally I think it's unfortunate.

Greetings,
-- Pete
