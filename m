Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261416AbSIWSpo>; Mon, 23 Sep 2002 14:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261320AbSIWSnG>; Mon, 23 Sep 2002 14:43:06 -0400
Received: from zeus.kernel.org ([204.152.189.113]:27041 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261400AbSIWSm1>;
	Mon, 23 Sep 2002 14:42:27 -0400
Message-ID: <3D8F2FE7.528593EF@opersys.com>
Date: Mon, 23 Sep 2002 11:14:47 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: linux-kernel <linux-kernel@vger.kernel.org>, LTT-Dev <ltt-dev@shafik.org>
Subject: Re: [PATCH] LTT for 2.5.37 2/9: Trace driver
References: <3D8CFD45.EA05DD5E@opersys.com> <20020922003837.A35@toy.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Pavel Machek wrote:
> Hi!
> 
> > +/*  Driver */
> > +static int           sMajorNumber;           /* Major number of the tracer */
> > +static int           sOpenCount;             /* Number of times device is open */
> > +/*  Locking */
> 
> Why *s*OpenCount? Some creeping infection by hungarian notation?

"static" as opposed 'l' for "local" elsewhere in the code, but you're looking
at code that is going to change to fit the usual kernel coding style. So all
those S's and L's will go away ;)

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
