Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129727AbRB1KeH>; Wed, 28 Feb 2001 05:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129828AbRB1Kd6>; Wed, 28 Feb 2001 05:33:58 -0500
Received: from ha1.rdc2.nsw.optushome.com.au ([203.164.2.50]:44161 "EHLO
	mss.rdc2.nsw.optushome.com.au") by vger.kernel.org with ESMTP
	id <S129727AbRB1Kdp>; Wed, 28 Feb 2001 05:33:45 -0500
Message-ID: <3A9CD304.26C3A568@optushome.com.au>
Date: Wed, 28 Feb 2001 21:29:24 +1100
From: Glenn McGrath <bug1@optushome.com.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Helge Hafting <helgehaf@idb.hist.no>
CC: linux-kernel@vger.kernel.org
Subject: Re: devfs and /proc/ide/hda
In-Reply-To: <3A9CCA76.3E6AB93A@optushome.com.au> <3A9CD2F3.E26A2884@idb.hist.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> 
> Glenn McGrath wrote:
> >
> > Im running kernel 2.4.1, I have entries like /proc/ide/hda,
> > /proc/ide/ide0/hda etc irrespective of wether im using devfs or
> > traditional device names.
> >
> > Is always using traditional device names for /proc/ide intentional, or
> > is it something nobody has gotten around to fixing yet?
> 
> Using devfs changes the names in /dev.  I don't think it
> is supposed to affect /proc in any way.  And there are programs out
> that use the existing /proc - changing it won't be popular.
> 

Well leaving it the way it is doesnt make much sense either really, it
refers to devices that dont exist.


Glenn
