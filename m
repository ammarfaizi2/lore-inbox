Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261295AbVBTCJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbVBTCJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 21:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbVBTCJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 21:09:57 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:62113 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261295AbVBTCJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 21:09:54 -0500
Message-ID: <4217F169.5090602@why.dont.jablowme.net>
Date: Sat, 19 Feb 2005 21:09:45 -0500
From: Jim Crilly <jim@why.dont.jablowme.net>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: jlnance@unity.ncsu.edu, Lee Revell <rlrevell@joe-job.com>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [OT] speeding boot process (was Re: [ANNOUNCE] hotplug-ng 001
 release)
References: <4d8e3fd305021400323fa01fff@mail.gmail.com> <42106685.40307@arcor.de> <1108422240.28902.11.camel@krustophenia.net> <524qge20e2.fsf@topspin.com> <1108424720.32293.8.camel@krustophenia.net> <42113F6B.1080602@am.sony.com> <1108430245.32293.16.camel@krustophenia.net> <20050217183709.GA11929@ncsu.edu> <20050217200009.GA19956@hh.idb.hist.no> <4216D509.7050206@why.dont.jablowme.net> <20050219224759.GA22874@hh.idb.hist.no>
In-Reply-To: <20050219224759.GA22874@hh.idb.hist.no>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> No problem with the remote server, it does not depend on the local boot process.
> The mail program connects directly to the remote server, all you need is the
> network and it comes up so fast, it will come up way before X in a parallel boot.

Depends on the implementation and what's required for network connectivity 
to the remote server. When I said that I was talking about the method that 
Lee Revell talked about, where he said "We should start X and initialize the 
display and get the login prompt up there ASAP, and let the system acquire 
the DHCP lease and start sendmail and apache and get the date from the NTP 
server *in the background while I am logging in*.  It's not rocket science". 
Obviously, if the network is started synchronously it won't matter.

> Helge Hafting

Jim.
