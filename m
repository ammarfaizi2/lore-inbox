Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265297AbSJXDQf>; Wed, 23 Oct 2002 23:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265300AbSJXDQf>; Wed, 23 Oct 2002 23:16:35 -0400
Received: from mx20b.rmci.net ([205.162.184.38]:17615 "HELO mx20b.rmci.net")
	by vger.kernel.org with SMTP id <S265297AbSJXDQe>;
	Wed, 23 Oct 2002 23:16:34 -0400
Subject: Re: [PATCH] niceness magic numbers, 2.4.20-pre11
From: Kristis Makris <devcore@freeuk.com>
To: Robert Love <rml@tech9.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1035402772.3171.1550.camel@phantasy>
References: <Pine.LNX.4.33L2.0210222332480.15859-100000@dragon.pdx.osdl.net> 
	<1035360961.4033.0.camel@irongate.swansea.linux.org.uk> 
	<1035402772.3171.1550.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 23 Oct 2002 20:22:42 -0700
Message-Id: <1035429764.528.8.camel@mcmicro>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > -#define	PRIO_MAX	20
> > > +#define	PRIO_MAX	19
> > 
> > I suspect this isnt correct
> 
> Agreed.  Its not.
> 
> It should remain 20 and places that truly want 19 should do PRIO_MAX-1.

Please excuse my inexperience; I don't understand why a 41 value range
is defined instead, and faked as a 40. Is this merely for the
convinience of ignoring 0 ? From the nice manpage:

"Range goes from -20 (highest priority) to 19 (lowest)."

Thanks,
Kristis

