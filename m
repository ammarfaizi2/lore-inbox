Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262874AbTJZDEd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 23:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262878AbTJZDEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 23:04:33 -0400
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:33417 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S262874AbTJZDEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 23:04:32 -0400
Date: Sun, 26 Oct 2003 04:04:25 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Jan Ploski <jpljpl@gmx.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-testX and pppd/pppoe stuck after connecting
In-Reply-To: <2523214.1067115416222.JavaMail.jpl@remotejava>
Message-ID: <Pine.LNX.4.53.0310260358130.2688@gockel.physik3.uni-rostock.de>
References: <2523214.1067115416222.JavaMail.jpl@remotejava>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Oct 2003, Jan Ploski wrote:

> I have been encountering problems with my pppd/pppoe setup.

I've never had any problems with pppoed in 2.[56]. (I am connected through
it right now).
There's one pitfall however: at least in the (somewhat rotten) SuSE 7.0
based setup I use, /etc/rc.d/pppoed explicitly checks the kernel version.
Since 2.6 perfectly works with the 2.4 settings, I just had to change the
case "2.4.*)" into "2.[456].*)"

Tim
