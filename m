Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131545AbRCNUPr>; Wed, 14 Mar 2001 15:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131551AbRCNUP1>; Wed, 14 Mar 2001 15:15:27 -0500
Received: from dfmail.f-secure.com ([194.252.6.39]:43532 "HELO
	dfmail.f-secure.com") by vger.kernel.org with SMTP
	id <S131545AbRCNUPY>; Wed, 14 Mar 2001 15:15:24 -0500
Date: Wed, 14 Mar 2001 22:23:23 +0200 (MET DST)
From: Szabolcs Szakacsits <szaka@f-secure.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Guennadi Liakhovetski <g.liakhovetski@ragingbull.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: system call for process information?
In-Reply-To: <Pine.GSO.4.21.0103141451310.4468-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.30.0103142206460.13864-100000@fs131-224.f-secure.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 14 Mar 2001, Alexander Viro wrote:
> On Wed, 14 Mar 2001, Szabolcs Szakacsits wrote:
> > read() doesn't really work for this purpose, it blocks way too many
> > times to be very annoying. When finally data arrives it's useless.
> Huh? Take code of your non-blocking syscall. Make it ->read() for
> relevant file on /proc or wherever else you want it. See read() not
> blocking...

Sorry I should have quoted "blocks". Problem isn't with blocking but
*no* data, no information. In the end you can conclude you know
*nothing* what happend in the last t time interval - this can be second,
minutes even with an RT, mlocked, etc process when the load is around 0.

	Szaka

