Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbTIXAUb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 20:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbTIXASe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 20:18:34 -0400
Received: from quechua.inka.de ([193.197.184.2]:38889 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261219AbTIXAS1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 20:18:27 -0400
From: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Possible Kernel 2.4.22 Bug - Please advise
Organization: Deban GNU/Linux Homesite
In-Reply-To: <3F70D21A.4010109@flashmail.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.1-20030907 ("Sandray") (UNIX) (Linux/2.4.20-xfs (i686))
Message-Id: <E1A1xLz-0006Xq-00@calista.inka.de>
Date: Wed, 24 Sep 2003 02:17:59 +0200
X-Scanner: exiscan *1A1xLz-0006Xq-00*hE8HCi/.E/c*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3F70D21A.4010109@flashmail.com> you wrote:
> to my ignorance on the topic, I finally got a booting kernel image. Yet, 
> with my new kernel, the boot sequence always fails to determine ip 
> information

this is more for kernel development, less for user support. But: have you
checked that both of your network cards have been found (with the same name
es before)

How do you assign the ip address in the first place? DHCP? MAybe you need
some packet socket stuff in the kernel config. Check out the syslog files,
especially /var/log/messages or /var/log/daemon.log or whatever it is called
on rh

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
