Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268388AbTBNNjN>; Fri, 14 Feb 2003 08:39:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268390AbTBNNjN>; Fri, 14 Feb 2003 08:39:13 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:10114
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268388AbTBNNjK>; Fri, 14 Feb 2003 08:39:10 -0500
Subject: Re: [PATCH][RFC] Proposal for a new watchdog interface using sysfs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rusty Lynch <rusty@linux.co.intel.com>
Cc: Matt Porter <porter@cox.net>, Scott Murray <scottm@somanetworks.com>,
       Patrick Mochel <mochel@osdl.org>, Dave Jones <davej@codemonkey.org.uk>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1045183679.1009.7.camel@vmhack>
References: <Pine.LNX.4.33.0302131317210.1133-100000@localhost.localdomain>
	 <Pine.LNX.4.44.0302131603500.23407-100000@rancor.yyz.somanetworks.com>
	 <20030213155817.B1738@home.com>  <1045173941.1009.4.camel@vmhack>
	 <1045183679.1009.7.camel@vmhack>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045234137.7958.17.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 14 Feb 2003 14:48:58 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-02-14 at 00:47, Rusty Lynch wrote:
> Ok, I had to go and read the driver-model documentation a couple of more
> times, but after I actually started writing some code it finally started
> to make sense.  

The watchdog_ops is probably a good thing anyway. If you also use that
same structure with the base watchdog module having the ioctl parser all
the ioctl handling funnies and quirks in the drivers go away except
for driver private stuff.

Two for the price of one

Alan

