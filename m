Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268492AbTBOAoG>; Fri, 14 Feb 2003 19:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268493AbTBOAoG>; Fri, 14 Feb 2003 19:44:06 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:22657
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268492AbTBOAoE>; Fri, 14 Feb 2003 19:44:04 -0500
Subject: Re: [PATCH][RFC] Proposal for a new watchdog interface using sysfs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rusty Lynch <rusty@linux.co.intel.com>
Cc: Pavel Machek <pavel@ucw.cz>, lkml <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>, Dave Jones <davej@codemonkey.org.uk>,
       Daniel Pittman <daniel@rimspace.net>
In-Reply-To: <1045264651.13488.40.camel@vmhack>
References: <1045106216.1089.16.camel@vmhack>
	 <1045160506.1721.22.camel@vmhack> <20030213230408.GA121@elf.ucw.cz>
	 <1045260726.1854.7.camel@irongate.swansea.linux.org.uk>
	 <20030214213542.GH23589@atrey.karlin.mff.cuni.cz>
	 <1045264651.13488.40.camel@vmhack>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045274042.2961.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 15 Feb 2003 01:54:03 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-02-14 at 23:17, Rusty Lynch wrote:
> The watchdog infrastructure would just show what ever integer the driver
> provides via the watchdog_ops.get_temperature() function pointer, so it
> would be up to the driver developer to decide if the data is really
> Fahrenheit or whatever.

We do need to be sure they all agree about it however 8)

