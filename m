Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131523AbRCNTpr>; Wed, 14 Mar 2001 14:45:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131524AbRCNTph>; Wed, 14 Mar 2001 14:45:37 -0500
Received: from dfmail.f-secure.com ([194.252.6.39]:37130 "HELO
	dfmail.f-secure.com") by vger.kernel.org with SMTP
	id <S131523AbRCNTpW>; Wed, 14 Mar 2001 14:45:22 -0500
Date: Wed, 14 Mar 2001 21:53:20 +0200 (MET DST)
From: Szabolcs Szakacsits <szaka@f-secure.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Guennadi Liakhovetski <g.liakhovetski@ragingbull.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: system call for process information?
In-Reply-To: <Pine.GSO.4.21.0103121324280.25792-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.30.0103142143300.13864-100000@fs131-224.f-secure.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 12 Mar 2001, Alexander Viro wrote:
> On Mon, 12 Mar 2001, Guennadi Liakhovetski wrote:
> > I need to collect some info on processes. One way is to read /proc
> > tree. But isn't there a system call (ioctl) for this? And what are those
> Occam's Razor.  Why invent new syscall when read() works?

read() doesn't really work for this purpose, it blocks way too many
times to be very annoying. When finally data arrives it's useless.

	Szaka

