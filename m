Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261530AbTB0G6I>; Thu, 27 Feb 2003 01:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261701AbTB0G6I>; Thu, 27 Feb 2003 01:58:08 -0500
Received: from dsl-212-144-205-077.arcor-ip.net ([212.144.205.77]:20359 "EHLO
	server1.intern.kubla.de") by vger.kernel.org with ESMTP
	id <S261530AbTB0G6E> convert rfc822-to-8bit; Thu, 27 Feb 2003 01:58:04 -0500
From: Dominik Kubla <dominik@kubla.de>
To: Kasper Dupont <kasperd@daimi.au.dk>, Miles Bader <miles@gnu.org>
Subject: Re: About /etc/mtab and /proc/mounts
Date: Thu, 27 Feb 2003 08:08:18 +0100
User-Agent: KMail/1.5
Cc: DervishD <raul@pleyades.net>, Linux-kernel <linux-kernel@vger.kernel.org>
References: <20030219112111.GD130@DervishD> <buoy942s6lt.fsf@mcspd15.ucom.lsi.nec.co.jp> <3E5DB2CA.32539D41@daimi.au.dk>
In-Reply-To: <3E5DB2CA.32539D41@daimi.au.dk>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200302270808.21035.dominik@kubla.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 February 2003 07:40, Kasper Dupont wrote:
> Miles Bader wrote:
> > Kasper Dupont <kasperd@daimi.au.dk> writes:

> > > My suggestion would be to change it from /etc/mtab to /mtab.d/mtab.
> >
> > Please, no.  don't pollute the root (_especially_ with little one-use
> > directories like that).
>
> Unfortunately it is the best solution I can come up with.
>
> > /var is clearly the right place for this;
>
> Is it?

I would recommend to replace /etc/mtab with a pseudo-FS like Sun did
for /etc/mnttab:

# uname -rs
SunOS 5.8
# mount -p
...
mnttab - /etc/mnttab mntfs - no dev=39c0000
...

Regards,
   Dominik
-- 
"What this  country needs is  a short, victorious war  to stem the  tide of
revolution." (V.K. von Plehve, Russian Minister  of Interior on the  eve of
the Russo-Japanese war.)

