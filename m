Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263786AbTLTC1E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 21:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263787AbTLTC1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 21:27:04 -0500
Received: from quechua.inka.de ([193.197.184.2]:57518 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S263786AbTLTC1C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 21:27:02 -0500
From: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>
To: linux-kernel@vger.kernel.org
Subject: Re: psmouse synchronization loss under load
Organization: Deban GNU/Linux Homesite
In-Reply-To: <20031220015131.GB9834@vitelus.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.2-20031104 ("Eriskay") (UNIX) (Linux/2.6.0-test11 (i686))
Message-Id: <E1AXWpR-0000Zm-00@calista.eckenfels.6bone.ka-ip.net>
Date: Sat, 20 Dec 2003 03:26:53 +0100
X-Scanner: exiscan *1AXWpR-0000Zm-00*4p2XPQ2LFfM*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20031220015131.GB9834@vitelus.com> you wrote:
> On a Dell laptop whenever I run a program that takes the full CPU, my
> mouse pointer goes insane and thrashes my X session every few minutes.

On my older system with 2.6.0 kernel i have currently this problem, whenever
APM tries to suspend the system. It will log that it was busy (screen
shortly gets black) and after that the genius ps2 mouse behaves like you
expected. Unplugging it helps.

The funny thing for me is, that those APM suspends most often only happen if
I actually _do_ something. I can reproduce it with Mozilla very often,
especially on loading flash sites. I guess I can solve that problem with
reconfiguring some of the APM options (I have tried to turn on as much as
possible on that PII4X 440BX System.

The sync problem with the mouse I have never seen with 2.4 kernels, not even
after suspends.

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
