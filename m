Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932342AbVLHU0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbVLHU0A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 15:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbVLHU0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 15:26:00 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:31909 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932342AbVLHUZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 15:25:59 -0500
Subject: Re: AW: Re: Linux in a binary world... a doomsday scenario
From: Lee Revell <rlrevell@joe-job.com>
To: Dave Neuer <mr.fred.smoothie@pobox.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <161717d50512081213oab71f63ncd9ecb3d721c83fc@mail.gmail.com>
References: <6798653.142371134056986823.JavaMail.servlet@kundenserver>
	 <1134070683.3919.26.camel@mindpipe>
	 <161717d50512081213oab71f63ncd9ecb3d721c83fc@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 08 Dec 2005 15:26:27 -0500
Message-Id: <1134073587.5149.4.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-08 at 15:13 -0500, Dave Neuer wrote:
> On 12/8/05, Lee Revell <rlrevell@joe-job.com> wrote:
> > On Thu, 2005-12-08 at 16:49 +0100, dirk@steuwer.de wrote:
> > > Yes, i can see the problem.
> > > How about interconnecting it with the bugtracker?
> > > If there is a bug, and if it is related to some hardware, it is logged
> > > in the database as broken for that kernel version. If the bug is
> > > fixed, support status is ok again.
> > > All that needs to be done is entering the device once into the
> > > database, status is broken by default, and take it from there?
> > > Then it gets some goals (similar to bugs) assigned if it is a complex
> > > device. i.e. for a graphic device:
> > > * 2d graphic support
> > > * 3d graphic support
> > > * framebuffer
> > > * vesa
> >
> > If we followed your scheme 95% of supported hardware would be listed as
> > broken.
> >
> > Lee
> 
> Well, let's start proposing solutions that will work then.
> 

I like the idea of a centralized database, split up by subsystem, that's
maintained by the developers in a similar way to the ALSA soundcard
matrix.  If a user finds an inaccuracy in the soundcard matrix or
discovers a new hardware model that works they submit a bug report
against the soundcard matrix, ideally containing a patch against the
XML.

It HAS to live alongside the code in the same version control system as
the code itself so it won't drift.

Lee

