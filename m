Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263038AbTC1QSs>; Fri, 28 Mar 2003 11:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263040AbTC1QSs>; Fri, 28 Mar 2003 11:18:48 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:6836 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S263038AbTC1QSs>; Fri, 28 Mar 2003 11:18:48 -0500
Date: Fri, 28 Mar 2003 17:30:29 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
cc: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: turning off kernel dhcp klient on _one_ nic?
In-Reply-To: <200303281030.35551.roy@karlsbakk.net>
Message-ID: <Pine.GSO.3.96.1030328172801.26178A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Mar 2003, Roy Sigurd Karlsbakk wrote:

> is it possible to turn off the kernel dhcp client / kernel autoconfiguration 
> on _one_ nic? We're using dual gigabit cards from intel (e1000), so splitting 
> up modular/static drivers obviously won't do the job. I've search through the 
> kernel doc, but I can't find anything...

 You may specify which interface to use explicitly with the "ip="
parameter -- see net/ipv4/ipconfig.c for details.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

