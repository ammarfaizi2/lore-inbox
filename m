Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261354AbVG1KPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261354AbVG1KPJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 06:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbVG1KMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 06:12:54 -0400
Received: from dslsmtp.struer.net ([62.242.36.21]:34576 "EHLO
	dslsmtp.struer.net") by vger.kernel.org with ESMTP id S261354AbVG1KMC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 06:12:02 -0400
Message-ID: <1770.80.166.175.197.1122545518.squirrel@80.166.175.197>
In-Reply-To: <20050728095724.GA32691@gamma.logic.tuwien.ac.at>
References: <20050728095724.GA32691@gamma.logic.tuwien.ac.at>
Date: Thu, 28 Jul 2005 12:11:58 +0200 (CEST)
Subject: Re: build system changed? cannot build any module
From: "Sam Ravnborg" <sam@ravnborg.org>
To: "Norbert Preining" <preining@logic.at>
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Andrew!
>
> I cannot build any external module (acerhk, pwc), in all the cases it
> the make run looks similar:
> make -C /lib/modules/`uname -r`/build SUBDIRS=/src/hotkey/acerhk-0.5.25
> modules
> make[1]: Entering directory `/usr/src/linux-2.6.13-rc3-mm2'
> scripts/Makefile.build:14:
> /usr/src/linux-2.6.13-rc3-mm2//src/hotkey/acerhk-0.5.25/Makefile: No such
> file or directory
> make[2]: *** No rule to make target
> `/usr/src/linux-2.6.13-rc3-mm2//src/hotkey/acerhk-0.5.25/Makefile'.  Stop.
>
> Has something fundamentally changed in the way external modules should
> be build?

A bug that I introduced.
I already posted a fix yesterday - please check
http://marc.theaimsgroup.com/?l=linux-kernel&m=112249231830476&w=2

   Sam


