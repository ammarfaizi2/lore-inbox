Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129884AbRAIPof>; Tue, 9 Jan 2001 10:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130464AbRAIPoZ>; Tue, 9 Jan 2001 10:44:25 -0500
Received: from hermes.mixx.net ([212.84.196.2]:27151 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129884AbRAIPoP>;
	Tue, 9 Jan 2001 10:44:15 -0500
Message-ID: <3A5B3114.FAC64E04@innominate.de>
Date: Tue, 09 Jan 2001 16:41:08 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>,
        linux-kernel@vger.kernel.org
Subject: Re: FS callback routines
In-Reply-To: <200101091405.IAA24807@tomcat.admin.navo.hpc.mil>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Pollard wrote:
> Daniel Phillips <phillips@innominate.de>:
> > This may be the most significant new feature in 2.4.0, as it allows us
> > to take a fundamentally different approach to many different problems.
> > Three that come to mind: mail (get your mail instantly without polling);
> > make (don't rely on timestamps to know when rebuilding is needed, don't
> > scan huge directory trees on each build); locate (reindex only those
> > directories that have changed, keep index database current).  As you
> > noticed, there are many others.
> > ...
> 
> It would also be very nice if the security of the feature could be
> confirmed. The problem with SGI's implementation is that it becomes
> possible to monitor files that you don't own, don't have access to,
> or are not permitted to know even exist.

To receive notification about events in a given directory you have to be
able to open it.  Is this adequate for your needs?

> For these reasons, we have disabled the feature.

It's nice to have that option, isn't it? ;-)

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
