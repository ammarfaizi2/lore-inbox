Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286959AbSCCPhf>; Sun, 3 Mar 2002 10:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287045AbSCCPhZ>; Sun, 3 Mar 2002 10:37:25 -0500
Received: from gear.torque.net ([204.138.244.1]:18193 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S286959AbSCCPhP>;
	Sun, 3 Mar 2002 10:37:15 -0500
Message-ID: <3C82434C.BA46E40E@torque.net>
Date: Sun, 03 Mar 2002 10:37:48 -0500
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.6-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: maintainer for raw.c ??
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tigran Aivazian <tigran@veritas.com> wrote:

> On Sat, 2 Mar 2002 WHarms@bfs.de wrote:
> 
> > hi list,
> > Who takes care of the raw-device section ?
> > I have a cleanup patch.
> > neither MAINTAINERS nor raw.c provide a hint (couldnt find one).
> >
> > walter
> 
> I would have thought Stephen Tweedie <sct@redhat.com> but I am not 100%
> sure.

Around the lk 2.4.6 timescale Stephen got "verballed"
on this list about the design of kiobufs (which lie
behind raw devices). Some patches went in from
Andrea Arcangeli. I don't think Stephen has had much
to do with raw devices or kiobufs since that time.

The good news is that raw devices in the lk 2.5 series
are now as fast (if not faster) than they were prior to
lk 2.4.6 . As an example, using the scsi_debug driver
(it's a ram disk) lk 2.4.18 yields 211 MB/sec while
in lk 2.5.6-pre2 that jumps up to 754 MB/sec on the
same hardware (1.2 GHz Athlon with DDR ram).

Doug Gilbert
