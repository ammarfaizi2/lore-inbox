Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262269AbTINAZk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 20:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262270AbTINAZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 20:25:40 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:46601 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S262269AbTINAZj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 20:25:39 -0400
From: Michael Frank <mhf@linuxmail.org>
To: Pat LaVarre <p.lavarre@ieee.org>, mpm@selenic.com
Subject: 2.6.0-test5: intermittent crash on chvt to X; was console lost to Ctrl+Alt+F$n in 2.6.0-test5
Date: Sun, 14 Sep 2003 08:24:24 +0800
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <1063378664.5059.19.camel@patehci2> <20030913015747.GC4489@waste.org> <1063460312.2905.13.camel@patehci2>
In-Reply-To: <1063460312.2905.13.camel@patehci2>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200309140824.25612.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I ended by running the third variant script quoted below. Now my logs
> comfortingly end with 'switching to X'. I presume I'm catching the
> crash in the last sleep $wait.

Makes sense because the crash may (in your case does) happen later 
in the switching sequence at which time the "new" log already made 
it to disk - I'll use your variant from now on ;)

The qestion now is whether this is kernel or X related.
Have you had this problem with an earlier 2.6 or 2.4 kernel?

If it is specific to -test5, post (as tar.bz2)

- lspci -v  
- /var/log/dmesg
- X version and driver info from /var/log/XFree86.log 
- .config

Regards
Michael

