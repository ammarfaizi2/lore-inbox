Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268294AbTCCCwB>; Sun, 2 Mar 2003 21:52:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268308AbTCCCwA>; Sun, 2 Mar 2003 21:52:00 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:39184 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S268294AbTCCCwA>; Sun, 2 Mar 2003 21:52:00 -0500
Date: Mon, 3 Mar 2003 03:02:24 +0000
From: John Levon <levon@movementarian.org>
To: Norbert Kiesel <nkiesel@tbdnetworks.com>
Cc: Ulrich Drepper <drepper@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Multiple & vs. && and | vs. || bugs in 2.4.20
Message-ID: <20030303030223.GA48286@compsoc.man.ac.uk>
References: <20030302121425.GA27040@defiant> <3E6247F7.8060301@redhat.com> <1046656929.16780.13.camel@voyager.tbdnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1046656929.16780.13.camel@voyager.tbdnetworks.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18pgDh-0007RK-00*UOUsE8ikmxw*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 02, 2003 at 06:03:57PM -0800, Norbert Kiesel wrote:

> What's IMHO more important is that the original code was producing the
> correct result, so the patch for acm.c is not really necessary.  This is
> also true for the patches for gus_midi.c, gus-wave.c, and i2c-proc.c.

Even the patch isn't *necessary* (i.e. does not change behaviour) it's
still a good idea.

I've been working on a -Wboolean-bitops. It seems to work at least a
bit, but I don't really know anything about gcc so it's probably
brain-damaged. Alas, current gcc CVS seems to have real issues with the
kernel ATM (as in, segfaults on scripts/empty.c immediately).

regards
john
