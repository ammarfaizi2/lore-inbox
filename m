Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbTJSQ5L (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 12:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbTJSQ5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 12:57:11 -0400
Received: from gaia.cela.pl ([213.134.162.11]:62738 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S261872AbTJSQ5J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 12:57:09 -0400
Date: Sun, 19 Oct 2003 18:57:05 +0200 (CEST)
From: Maciej Zenczykowski <maze@cela.pl>
To: Valdis.Kletnieks@vt.edu
cc: Wichert Akkerman <wichert@wiggy.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] add a config option for -Os compilation 
In-Reply-To: <200310191631.h9JGVEN5030083@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.44.0310191853220.19283-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> OK, so the applications are limited to /sbin/iptables, /sbin/route, /bin/
> netstat, and maybe dhcpd and/or zebra. They're still applications, even if they
> end up invoking a lot of kernel resources on their behalf.

/sbin/iptables and /sbin/route are merely configuration interfaces to the 
kernel proper, not really familiar with netstat - but as far as I know all 
it does is dumps kernel runtime configuration and statistics.  That's 3 
utilities which are no way apps - just interfaces.  Now dhcpd is an app 
and zebra is an app - but they are still mainly kernel oriented.  The 
first 3 depend only on kernel speed and the next 2 depend mostly on kernel 
speed.  I'd say you just proved how important kernel optimilization is for 
routers.

Cheers,
MaZe.


