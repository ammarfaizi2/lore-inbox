Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265369AbTABCYq>; Wed, 1 Jan 2003 21:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265385AbTABCYq>; Wed, 1 Jan 2003 21:24:46 -0500
Received: from tomts11.bellnexxia.net ([209.226.175.55]:3481 "EHLO
	tomts11-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S265369AbTABCYp>; Wed, 1 Jan 2003 21:24:45 -0500
Date: Wed, 1 Jan 2003 21:32:15 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: Tomas Szepe <szepe@pinerecords.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: observations on 2.5 config screens
In-Reply-To: <Pine.LNX.4.33L2.0301011750010.21149-100000@dragon.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0301012129530.2431-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jan 2003, Randy.Dunlap wrote:

> Greg Banks has (had) a real nice program for checking
> dependency ordering using Config.in files.  It would be
> very nice if it now worked with Kconfig files.  :)
> It could be used for this type of config reordering to
> verify that things weren't screwed up.  I used it when
> I moved Network Devices to just under/after Network Options
> to show that no dependency ordering was mangled by that patch.

so are you saying that there should be no backward dependencies
in the list of menus?  i remember just that in the 2.4 screens,
when you could select hardware sensors and then, on a 
subsequent screen, deselect I2C which would, as a result,
deselect sensors on that previous screen.

you're saying that, the way these menus are ordered, this
type of thing should be avoided?

rday

