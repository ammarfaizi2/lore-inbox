Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267345AbTBNTdx>; Fri, 14 Feb 2003 14:33:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267367AbTBNTdx>; Fri, 14 Feb 2003 14:33:53 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:41600
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267345AbTBNTdw>; Fri, 14 Feb 2003 14:33:52 -0500
Subject: Re: [PATCH][RFC] Proposal for a new watchdog interface using sysfs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rusty Lynch <rusty@linux.co.intel.com>
Cc: Matt Porter <porter@cox.net>, Scott Murray <scottm@somanetworks.com>,
       Patrick Mochel <mochel@osdl.org>, Dave Jones <davej@codemonkey.org.uk>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1045249341.13262.10.camel@vmhack>
References: <Pine.LNX.4.33.0302131317210.1133-100000@localhost.localdomain>
	 <Pine.LNX.4.44.0302131603500.23407-100000@rancor.yyz.somanetworks.com>
	 <20030213155817.B1738@home.com>  <1045173941.1009.4.camel@vmhack>
	 <1045183679.1009.7.camel@vmhack>
	 <1045234137.7958.17.camel@irongate.swansea.linux.org.uk>
	 <1045236757.12974.14.camel@vmhack>
	 <1045245352.1353.35.camel@irongate.swansea.linux.org.uk>
	 <1045249341.13262.10.camel@vmhack>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045255428.1854.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 14 Feb 2003 20:43:48 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-02-14 at 19:02, Rusty Lynch wrote:
> If /dev/watchdog is a link to a sysfs file, then (at least in sysfs's
> current state) you loose the ability to handle the documented watchdog
> ioctl's.  That is why I assumed that the watchdog base.c could implement
> a miscdev registered for the watchdog minor (130), and then translate
> the documented ioctl's into the watchdog_ops calls for the the specific
> driver that is currently associated with the miscdevice.

sysfs is not capable of handling ioctl forwarding ? Oops, then I guess
the mess has to live on

