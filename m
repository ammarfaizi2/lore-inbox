Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbTIMBq2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 21:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbTIMBq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 21:46:28 -0400
Received: from [139.30.44.2] ([139.30.44.2]:60892 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S261984AbTIMBq1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 21:46:27 -0400
Date: Sat, 13 Sep 2003 03:46:18 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Tabris <tabris@tabris.net>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Jiffies_64 for 2.4.22-ac
In-Reply-To: <200309121338.02444.tabris@tabris.net>
Message-ID: <Pine.LNX.4.33.0309130333360.24996-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > while with your patches one has to use -p2.
> >
> short of running sed on my patches or changing my own tree structure, I'm
> not sure how to change this.

sed is one option, links are another.

> Marcelo changed it from $version/linux to linux-$version and when using
> old Linus 2.4  patches, one does a patch -p 1 from $version/ but Marcelo
> patches, i have to do it from linux/

Linus' 2.4 patches used $version/linux/ for the old tree and linux/ for
the new one, so they worked with -p1 from inside linux/ as well.

Anyways, I don't bother too much. It's just a short moment of irritation
when the first filename isn't found.

Tim


