Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271937AbTG2R3J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 13:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271941AbTG2R3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 13:29:09 -0400
Received: from 206-158-102-129.prx.blacksburg.ntc-com.net ([206.158.102.129]:15267
	"EHLO wombat.ghz.cc") by vger.kernel.org with ESMTP id S271937AbTG2R3H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 13:29:07 -0400
Message-ID: <35162.216.12.38.216.1059499746.squirrel@www.ghz.cc>
In-Reply-To: <1059496775.1660.3.camel@beowulf.cryptocomm.com>
References: <1059496775.1660.3.camel@beowulf.cryptocomm.com>
Date: Tue, 29 Jul 2003 13:29:06 -0400 (EDT)
Subject: Re: kernel-2.6.0-test2 speedy gonzalez mouse
From: "Charles Lepple" <clepple@ghz.cc>
To: adam@cryptocomm.com
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Voigt said:
> 2.6.0-test2 works great for me, with the exception of the
> mouse, which seems to have been hyper-accelerated by the kernel
> upgrade.

You have the /dev/psaux device enabled in the kernel, and chances are your
X server is reading from /dev/input/mice as well. Try disabling the psaux
device in the kernel, or removing one of the mouse lines from XF86Config.

-- 
Charles Lepple <clepple@ghz.cc>
http://www.ghz.cc/charles/
